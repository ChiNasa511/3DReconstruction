% All formulas and values from:
% Khoshelham, K., & Elberink, S. O. (2012).
% Accuracy and resolution of Kinect depth data for indoor mapping applications.
% Sensors (Basel, Switzerland), 12(2), 1437?54. doi:10.3390/s120201437

load('meeting_small_1.mat')
pc=zeros([size(D) 3]);
W=size(D,2);
H=size(D,1);
f=5.453;
for indWidth = 1:W
    for indHeight= 1:H
        % copy z value
        pc(indHeight,indWidth,3)=D(indHeight,indWidth);
        % calc x value
        pc(indHeight,indWidth,1)=-(pc(indHeight,indWidth,3)/f)*...
            ((indWidth-W/2)*0.0093+0.063);
        % calc y value
        pc(indHeight,indWidth,2)=-(pc(indHeight,indWidth,3)/f)*...
            ((indHeight-H/2)*0.0093+0.039);
    end
end
X=pc(:,:,1);
% X=X(:);
Y=pc(:,:,2);
% Y=Y(:);
Z=-pc(:,:,3);
Z(Z==0)=NaN;

Surface=surf(X,Y,Z,'edgecolor','none','facecolor','interp');
lighting gouraud
camlight
% colormap(repmat(winter,20,1))
axis image
axis vis3d
xlabel('X axis')
ylabel('Y axis')
zlabel('Z axis')
