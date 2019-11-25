% orig_video = VideoReader('original_3.mp4');
tooned_video = VideoWriter('Output/Output_v.avi');
scaled_orig = VideoReader('data/scaled_original.avi');

tooned_video.FrameRate = scaled_orig.FrameRate;
% scaled_orig.FrameRate = orig_video.FrameRate;

open(tooned_video);
% open(scaled_orig);

while hasFrame(scaled_orig)
    cartoon_img = Toonify_v(readFrame(scaled_orig));
    writeVideo(tooned_video,cartoon_img);
end    

close(tooned_video);
% close(scaled_orig);
