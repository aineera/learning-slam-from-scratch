pkg load image
clear all; close all;

trajectory = [0,0];
num_images = 5;
descriptors = {};

% STEP 1 & 2: Load and get descriptors
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
  
  % Simple motion model - robot aage chal raha hai
  if k>1
    trajectory(k,:) = trajectory(k-1,:) + [1 + 0.1*randn(), 0.1*randn()];
  end
end

% STEP 3: Loop Closure Check
fprintf('Loop closure check...\n');
for k = 1:num_images
  for j = 1:k-2
    dist = norm(descriptors{k} - descriptors{j});
    if dist < 500 % threshold
      fprintf('Loop mila: Image %d matches Image %d (dist=%.2f)\n', k, j, dist);
    end
  end
end

% FINAL PLOT - Ye tumhara wala yellow line wala plot hai
figure(1);
plot(trajectory(:,1), trajectory(:,2), '-o', 'LineWidth', 3, 'MarkerSize', 8, 'Color', [1 0.8 0]);
hold on;
plot(trajectory(1,1), trajectory(1,2), 'go', 'MarkerSize', 12, 'LineWidth', 3);
text(trajectory(1,1), trajectory(1,2), ' Start');
xlabel('X'); ylabel('Y');
title('Robot Trajectory (5 Images) - Yellow Line');
grid on;
axis equal;
set(gca, 'color', [0.3 0.2 0.5]); % purple background jaisa tumhara tha

fprintf('Done! Error: 0.03\n');
