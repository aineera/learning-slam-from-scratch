% Main SLAM - Sab yahan se start
disp('SLAM Started...');
features = tracking();
my_map = map(features);
disp('Map ban gaya!');
