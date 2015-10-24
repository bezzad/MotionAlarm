%% The project work in motion pictures are motion detection.
%#########################################################################%
%% Read Beep Sound --------------------------------------------------------
s7 = wavread('beep-7.wav');
s8 = wavread('beep-8.wav');
beep on;
%-------------------------------------------------------------------------%
%% Define Webcam output data ==============================================
adaptorName = 'winvideo';
deviceID = 1;
DefaultFormat= 'RGB555_128x96';
vidFormat = 'RGB24_640x480';
vidObj1 = videoinput(adaptorName, deviceID, DefaultFormat);
start(vidObj1)
preview(vidObj1);
%=========================================================================%
%% Read Data and Motion Detect ++++++++++++++++++++++++++++++++++++++++++++
 if(isrunning(vidObj1))
    % New background update only 40 times to
    % search for moving images is applied.
    for j=1:1:40 
        % Reduce processing time, 
        % the background color image to gray image will become.
        B = rgb2gray(getsnapshot(vidObj1));
        % After comparing the background image
        % every 8 to 8 files can be updated.
        for i=1:8
            % Because the gray background image in ourselves, 
            % so it should also compare the images to gray.
            frame = rgb2gray(getsnapshot(vidObj1));
            %% Match background B by frame
            [w, h] = size(B); % in this project : w=640 , h=480
            %
            % Count the number of disputes are images with
            % the same background or primary image.
            detectionCounter = 0;
            %
            % Review every single pixel wallpapers and images present time.
            for x=1:w
                for y=1:h
                    % Carefully compare the light gray images is ±20.
                    if(frame(x, y) >= (B(x, y) + 15) || frame(x, y) <= (B(x, y) - 15))
                        % If the top 15 by the difference between the pixel
                        % brightness background and image, to counter increased.
                        detectionCounter = detectionCounter + 1;
                    end
                end
            end
           % Defined threshold number of pixels of light intensity changes.
            if(detectionCounter > 500 && detectionCounter < 50000)
                beep;
            elseif(detectionCounter >= 50000 && detectionCounter < 150000)
                sound(s7);
                if(i<7) i=8; end
            elseif(detectionCounter >= 150000 && detectionCounter < 307201)
                sound(s8);
                if(i<7) i=8; end
            else i=5;
            end
        end
    end
    % End of Motion Alarm
    delete(vidObj1);
 end
 %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
 %% END of Motion Detect 
 return;
