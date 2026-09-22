% Phase 1 - Trajectory estimation + movmean smoothing
function smooth_traj = trajectory_estimation(traj)
  % traj = [x, y] positions
  smooth_traj = movmean(traj, 5); % 5 window smoothing
  plot(smooth_traj);
  title('Smoothed Trajectory');
end
