% Phase 1 - Binary descriptor + Hamming distance
function dist = hamming_distance(desc1, desc2)
  % Hamming = count different bits
  dist = sum(xor(desc1, desc2));
  disp(['Hamming Distance: ', num2str(dist)]);
end
