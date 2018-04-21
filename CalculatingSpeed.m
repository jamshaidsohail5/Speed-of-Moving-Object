%% Calculate velocity of the ball
videoFileReader = vision.VideoFileReader('C:\Users\Aqsa Sohail\Desktop\video.avi');
videoPlayer = vision.VideoPlayer('Position',[100 100 600 400]);
oldPoints = [];

while ~isDone(videoFileReader)
    videoFrame = step(videoFileReader);
    G = rgb2gray(videoFrame);
    
    BW = G > 0.5;
    BW2 = bwareaopen(BW, 30);
    BW3 = imfill(BW2, 'holes');
    stats = regionprops('table',BW3,'Centroid');
    
    points = table2array(stats);
    if ~isempty(oldPoints)
        % Calculate velocity (pixels/frame)
        vel_pix = sqrt(sum((points-oldPoints).^2,2));
        vel = vel_pix * 1 * 10; 
    else
        vel_pix = 0;
        vel = 0;
    end
 % Visualize the velocity
      videoFrameOut = insertObjectAnnotation(videoFrame, 'circle', ...
          [points 10*ones(size(points,1),1)], ...
          cellstr(num2str(vel,'%2.2f')));
      step(videoPlayer, videoFrameOut);
      oldPoints = points;
end
release(videoFileReader);
release(videoPlayer);
	
