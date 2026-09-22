pkg load image
clear all; close all;

num_images = 5;
trajectory = zeros(num_images, 2);
descriptors = {};

% --- KALMAN FILTER SETUP ---
x = [0; 0]; % initial state [x; y]
P = eye(2) * 1.0; % covariance
Q = eye(2) * 0.01; % process noise - robot kitna hilta hai
R = eye(2) * 0.1; % measurement noise - image se kitni error
F = eye(2); % state transition
H = eye(2); % measurement model

trajectory(1,:) = x';

% STEP 1: Load + Kalman
for k = 1:num_images
  img_name = sprintf('i%d.png', k);
  img = imread(img_name);
  if size(img,3)==3
    gray = rgb2gray(img);
  else
    gray = img;
  end
  [h,w] = size(gray);
  patch = gray(floor(h/2)-7:floor(h/2)+8, floor(w/2)-7:floor(w/2)+8);
  desc = double(patch(:))';
  descriptors{k} = desc;

  if k > 1
    % --- PREDICTION ---
    u = [1; 0.02*randn()]; % robot 1 meter aage
    x = F * x + u;
    P = F * P * F' + Q;

    % --- UPDATE (measurement) ---
    % measurement z = odometry se
    z = x + [0.1*randn(); 0.1*randn()];
    
    K = P * H' * inv(H * P * H' + R); % Kalman Gain
    x = x + K * (z - H*x);
    P = (eye(2) - K*H) * P;
    
    trajectory(k,:) = x';
  end
end

% STEP 2: Loop Closure (wahi tumhara)
fprintf('Loop closure check (with Kalman)...\n');
figure(1); clf;
plot(trajectory(:,1), trajectory(:,2), '-o', 'LineWidth', 3, 'MarkerSize', 8, 'Color', [1 0.8 0]);
hold on;
plot(trajectory(1,1), trajectory(1,2), 'go', 'MarkerSize', 12, 'LineWidth', 3);

for k = 1:num_images
  for j = 1:k-2
    dist = norm(descriptors{k} - descriptors{j});
    fprintf('i%d vs i%d -> dist=%.2f\n', k, j, dist);
    if dist < 500
      fprintf('*** LOOP MILA: i%d == i%d (Kalman corrected) ***\n', k, j);
      plot([trajectory(k,1), trajectory(j,1)], [trajectory(k,2), trajectory(j,2)], 'r--', 'LineWidth', 2);
      
      % --- LOOP PE KALMAN CORRECTION ---
      % jab loop mile to covariance kam kardo
      P = P * 0.5;
    end
  end
end

xlabel('X'); ylabel('Y');
title('SLAM with Kalman Filter - Yellow Trajectory + Red Loop');
grid on; axis equal;
set(gca, 'color', [0.3 0.2 0.5]);
fprintf('Done! Kalman Error: %.4f\n', trace(P));
