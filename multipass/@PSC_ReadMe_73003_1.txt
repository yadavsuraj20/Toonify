Title: Multipass BILATERAL FILTER. (V4) [better computation precision, RGB and CieLAB color Spaces]
Description: This application applies Multipass Bilateral Filter to color Images.
Bilateral filtering is an Edge-preserving smoothing filter. This technique extends the 
concept of Gaussian smoothing by weighting the filter coefficients with their corresponding 
relative pixel intensities. Pixels that are very different in intensity from the central 
pixel are weighted less even though they may be in close proximity to the central pixel. 
This is effectively a convolution with a non-linear Gaussian filter, with weights based on 
pixel intensities. This is applied as two Gaussian filters at a localized pixel neighborhood 
, one in the spatial domain, and one in the intensity domain.
Some Parameters make result image with a cartoon-like appearance.
[ can someone speed up EFF_BilateralFilter Sub? ]
This file came from Planet-Source-Code.com...the home millions of lines of source code
You can view comments on this code/and or vote on it at: http://www.Planet-Source-Code.com/vb/scripts/ShowCode.asp?txtCodeId=73003&lngWId=1

The author may have retained certain copyrights to this code...please observe their request and the law by reviewing all copyright conditions at the above URL.
