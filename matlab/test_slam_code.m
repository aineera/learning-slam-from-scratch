% Mini_SLAM_5_Images.m - 5 images se pura SLAM
pkg load image

function bits = get_descriptor(patch)
  bits = double(patch) > mean(patch(:));
  bits = bits(:)';
end

function d = hamming(d1,d2)
  d = sum(xor(d1,d2));
end

%% STEP 1: 5 Images Load karo (robot aage ja raha hai)
% Tumhare paas image1.jpg se image5.jpg honi chahiye
% Agar nahi hai to ek hi image ko 5 bar copy karke naam badal do

num_images = 5;
descriptors = {};
trajectory = [0,0]; % start 0,0 se

fprintf('Robot chalna shuru...\n');

for i = 1:num_images
  img_name = sprintf('image%d.jpg', i);
  img = imread(img_name);
  if size(img,3)==3
    gray = rgb2gray(img);
  else
    gray = img;
  end

  % STEP 2: Sobel se nahi, beech ka patch le ke descriptor banao (simple)
  [h,w] = size(gray);
  patch = gray(floor(h/2)-8:floor(h/2)+7, floor(w/2)-8:floor(w/2)+7);
  desc = get_descriptor(patch);
  descriptors{i} = desc;

  % STEP 3A: Successive Hamming (Odometry) - Robot kitna hila?
  if i > 1
    dist_successive = hamming(descriptors{i}, descriptors{i-1});
    fprintf('Image %d vs Image %d (successive): Hamming = %d\n', i, i-1, dist_successive);
    
    % Agar distance kam hai to robot thoda hila, zyada hai to zyada hila
    % Simple odometry: distance se movement guess
    move = dist_successive / 50; % scaling
    new_pos = trajectory(end,:) + [move, randn*0.1];
    trajectory = [trajectory; new_pos];
  end

  % STEP 3B: Loop Closure - Kya ye jagah pehle dekhi hai?
  % Current image ko purani sab images (except last wali) se compare
  if i > 2
    for j = 1:i-2 % i-1 ko skip karo
      loop_dist = hamming(descriptors{i}, descriptors{j});
      if loop_dist < 25 % threshold
        fprintf('>>> LOOP CLOSURE! Image %d matches Image %d (dist=%d)\n', i, j, loop_dist);
        % Loop mila to trajectory ko wapas j par le ao
        trajectory(end,:) = trajectory(j,:);
      end
    end
  end
end

%% STEP 4: Map aur Trajectory Plot

% Map banao
map = zeros(20,20);
map(10, 5:15) = 1;

figure;
imagesc(map); colormap(gray); hold on; axis xy;
plot(trajectory(:,2)*5+10, trajectory(:,1)*5+10, 'r-o', 'LineWidth',2);
title('5 Images Mini-SLAM - Trajectory + Map');
xlabel('X'); ylabel('Y');
legend('Path');
grid on;

disp('SLAM Complete!');
disp(trajectory);
