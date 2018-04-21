%% Clearing the window and the previous variables
clear 
clc

%% Create a video for detection
writerObj = VideoWriter('C:\Users\Aqsa Sohail\Desktop\video.avi');
open(writerObj);

%% setting the background of image
bgI = zeros(240,320,'uint8');

%% initial position of the ball
pos_org = [100 50];

%% radius of the ball
r = 15;
frames = 60;

%% creating the video
for k = 1: frames
    pos = pos_org + 1*[0 5];
	pos_org = pos;
	I = insertShape(bgI, 'FilledCircle', [pos r], 'Color', 'white');
    I = I + uint8(randn(size(I)))*10;
    writeVideo(writerObj,im2frame(I));
end
close(writerObj);

