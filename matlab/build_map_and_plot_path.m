% Phase1_Path_And_Map.m

function [map] = build_map_and_plot_path(traj)
  % 20x20 ka khali map banao (0 = khali jagah)
  map = zeros(20, 20);

  % Beech mein deewar laga do (1 = deewar)
  map(10, 5:15) = 1;
  map(5:15, 10) = 1;

  % Trajectory ko map par convert karo
  % traj jaise [1.2, 2.5] -> map par [1, 2] index
  figure;
  imagesc(map); % map dikhao
  colormap(gray); hold on;
  axis xy;

  % Path plot karo
  plot(traj(:,2)*2, traj(:,1)*2, 'r-o', 'LineWidth', 2);

  title('Path and Map - Robot ka rasta map par');
  legend('Robot Path');
  xlabel('Map X'); ylabel('Map Y');
end

% --- TEST EXAMPLE ---
% Fake trajectory
t = 0:0.5:8;
traj = [t', sin(t)'+10]; % 10 shift taake map ke andar aaye

build_map_and_plot_path(traj);
