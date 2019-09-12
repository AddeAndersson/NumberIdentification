function []=ima(A)
% Function to show digits in matrix form
% Call with: ima(A)
% Translates matrix to become nonnegative
% and scales to interval [0,20]

a1=squeeze(A);
a1=(a1-min(min(a1))*ones(size(a1)));
a1=(20/max(max(a1)))*a1;

mymap1 =[1.0000    1.0000    1.0000
    0.8715    0.9028    0.9028
    0.7431    0.8056    0.8056
    0.6146    0.7083    0.7083
    0.4861    0.6111    0.6111
    0.3889    0.4722    0.5139
    0.2917    0.3333    0.4167
    0.1944    0.1944    0.3194
    0.0972    0.0972    0.1806
         0         0    0.0417];
colormap(mymap1)

image(a1)
axis off
axis equal

