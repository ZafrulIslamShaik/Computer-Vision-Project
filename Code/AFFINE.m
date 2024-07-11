clc;
close all;
% To read the three distorted images
A_distorted_img = double (imread('distorted_img_A.png'));
B_distorted_img = double (imread('distorted_img_B.png'));
C_distorted_img = double (imread('distorted_img_C.png'));
% To form and read a greyscale flower_image 
intial_img = double (rgb2gray(imread('flower_image.jpg')));
% To read the target_image
final_img = double (imread('target_img.png'));
% image information 
image_info=imfinfo('distorted_img_A.png');
image_width=image_info.Width;
image_height=image_info.Height;
disp(image_width);
% Applying affine transformation to the start_image
H = [0.8 0.2 0; 0.1 0.7 0; 0 0 1];

% Calling the affine function to transform the initial image using H matrix
affine = geotrans (H, intial_img);

% assigning Centre and radius of circle to form on imagee
Xposition = 60;
Yposition = 52;
radii = 10;

% Initialising the i value 
i=1;

% Getting the starting position of image
if i==4
    n = 72;
 
elseif i==1
    % To assign the distorted_img_A
    n = 46;
    affine=A_distorted_img;
    intial_img=final_img;
   
elseif i==2
   % To assign the distorted_img_B
    n=1;
    affine=B_distorted_img;
    intial_img=final_img;
    
   % To assign the distorted_img_C
elseif i==3 
    n=54;
    affine=C_distorted_img;
    intial_img=final_img;
     
end

figure(1);
% Plotting the start image in 1st position using subplot function
subplot(1,3,1);
imshow(intial_img,[],'Border','tight');
viscircles([Xposition, Yposition], radii, 'EdgeColor', 'b', 'LineWidth', 3);
title('First Img');

% Plotting the Transformed image in 2nd position using subplot function
subplot(1,3,2);
imshow(affine,[],'Border','tight');
viscircles([Xposition, Yposition], radii, 'EdgeColor', 'b', 'LineWidth', 3);
title('Affine Img');

% Plotting the Transformed image in 3rd position using subplot function
 subplot(1,3,3);
 imshow(geotrans(inv(H),affine),[],'Border','tight');
%  viscircles([Xposition, Yposition], radii, 'EdgeColor', 'b', 'LineWidth', 3);
 title('Original Img');

figure(2);
% Plotting the transformed affine image in 1st postion using subplot function
subplot(1,2,1);
imshow(affine,[],'Border','tight');
viscircles([Xposition, Yposition], radii, 'EdgeColor', 'b', 'LineWidth', 3);
title('Affine Img');

% Plotting the transformed affine image in 2nd postion using subplot function
for i= 1:n
    figure(2);
    subplot(1,2,2);
    imshow(geotrans(inv(LSM (intial_img,image_width,image_height)), affine),[]);
    viscircles([Xposition, Yposition], radii, 'EdgeColor', 'b', 'LineWidth', 3);
    title(['iterations :' num2str(i)]);
end

% Processing of Iterations

% for obtaining the gradient
[fx, fy] = gradient(intial_img, 2); 

figure(3);
% Plotting the Gradient of start image in 1st position using subplot function
subplot(1,2,1);
imshow (fx,[],'Border','tight');
viscircles([Xposition, Yposition], radii, 'EdgeColor', 'b', 'LineWidth', 3);
title('fx');

% Plotting the Gradient of start image in 2nd postion using subplot function
subplot(1,2,2);
imshow (fy,[],'Border','tight');
viscircles([Xposition, Yposition], radii, 'EdgeColor', 'b', 'LineWidth', 3);
title('fy');
