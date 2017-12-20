% 3D Reconstruction
%
% Chinasa T. Okolo
% CSCI 181P
% Project
% 
% Combine multiple point clouds to reconstruct a 3-D 
% scene using Iterative Closest Point (ICP) algorithm.
%  
% Code referenced from: MathWorks StitchPointCloudsExample

% Register two point clouds
dataFile = ('meeting_small_1.mat');
load(dataFile);

% Extract two consecutive point clouds and use the first point cloud as
% reference.
depth1 = imread('meeting_small_1_1_depth.png'); 
[pcloud1, distance1] = depthToCloud(depth1);

depth2 = imread('meeting_small_1_2_depth.png'); 
[pcloud2, distance2] = depthToCloud(depth2);

ptCloudRef = pointCloud(pcloud1);
ptCloudCurrent = pointCloud(pcloud2);

% Create grid filter
gridSize = 0.1;
fixed = pcdownsample(ptCloudRef, 'gridAverage', gridSize);
moving = pcdownsample(ptCloudCurrent, 'gridAverage', gridSize);

% Find rigid transformation
tform = pcregrigid(moving, fixed, 'Metric','pointToPlane','Extrapolate', true);
ptCloudAligned = pctransform(ptCloudCurrent,tform);

% Create the 3D scene
mergeSize = 0.015;
ptCloudScene = pcmerge(ptCloudRef, ptCloudAligned, mergeSize);

% Visualize the input images.
figure
subplot(2,2,1)
imshow(ptCloudRef.Color)
title('First input image')
drawnow

subplot(2,2,3)
imshow(ptCloudCurrent.Color)
title('Second input image')
drawnow

% Visualize the world scene.
subplot(2,2,[2,4])
pcshow(ptCloudScene, 'VerticalAxis','Y', 'VerticalAxisDir', 'Down')
title('Initial world scene')
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
drawnow