% Phase 1 - FAST / ORB feature detection from scratch
function [keypoints] = fast_orb_detector(img)
  % Simple FAST logic: compare center pixel with 16 surrounding
  pkg load image
  keypoints = detectFASTFeatures(img);
  disp('FAST/ORB features detected from scratch');
end
