% Phase 1 - Sobel filter from scratch
function edges = sobel_filter(img)
  % Sobel X and Y
  Sx = [-1 0 1; -2 0 2; -1 0 1];
  Sy = [-1 -2 -1; 0 0 0; 1 2 1];
  Gx = conv2(double(img), Sx, 'same');
  Gy = conv2(double(img), Sy, 'same');
  edges = sqrt(Gx.^2 + Gy.^2);
end
