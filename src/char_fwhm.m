function [xwidth,xleft,xright] = char_fwhm(x,y,threshold)
% Estimation of function width at threshold level
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function returns an estimate of the full-width of a function at a
% specified threshold level. For returning the full-width at half-maximum, 
% set threshold = 0.5
% This function is not robust. It is the responsibility of the user to
% ensure the function width is well defined at the specified threshold
% value.
% A linear interpolation is used to assess the intersection points between
% the function and the threshold level.
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% [tfwhm,trise,tfall] = char_fwhm(time_array,abs(sig).^2,0.5);
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% x                 values at which the function is defined [real vector]
%
% y                 values taken by the function at the specified x values
%                       [real vector]
%
% threshold         threshold value, expressed as a percentage of the
%                       maximum value of the function [real scalar]
%
%                       Use threshold = 0.5 for estimating the full-width
%                       at half-maximum.
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% xwidth            function width [real scalar]
%
% xleft             estimated value of the lower crossing point 
%                       [real scalar]
%
% xright             estimated value of the higher crossing point 
%                       [real scalar]
%
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

y = y/max(y);
% Normalise the function so that its peak value is unity

indices_above = find(y >= threshold);
% Find the indices for which the function values are larger than the
% threshold

x0 = x(indices_above(1) - 1);
y0 = y(indices_above(1) - 1);

x1 = x(indices_above(1));
y1 = y(indices_above(1));

xleft = x0 + (threshold - y0)/(y1 - y0)*(x1 - x0);
% Linear interpolation on the lower x value side

x0 = x(indices_above(end));
y0 = y(indices_above(end));

x1 = x(indices_above(end) + 1);
y1 = y(indices_above(end) + 1);

xright = x0 + (threshold - y0)/(y1 - y0)*(x1 - x0);
% Linear interpolation on the higher x value side

xwidth = xright - xleft; 
% Width at threshold


end