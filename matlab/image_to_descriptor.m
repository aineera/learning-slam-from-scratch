function [bits] = image_to_descriptor(patch)
  % patch = e.g. 8x8 ya 16x16 image ka tukda (grayscale)
  % Isko binary descriptor mein convert karega

  patch = double(patch);
  center = mean(patch(:)); % average intensity
  bits = patch > center; % jo pixel average se bara hai = 1, chota = 0

  bits = bits(:)'; % 1 row mein kar do
  disp('Image patch -> Binary IDs:');
  disp(bits);
end

function dist = hamming_distance(desc1, desc2)
  dist = sum(xor(desc1, desc2));
end

% --- TEST ---
% Koi bhi 8x8 image patch lo
% img = imread('test.jpg');
% gray = rgb2gray(img);
% patch = gray(10:17, 10:17); % 8x8 tukda
% desc = image_to_descriptor(patch)
