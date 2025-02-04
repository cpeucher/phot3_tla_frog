function sig = normalise_field(sig)
% Normalise pulse to unit value and center it to half time window
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function ensures the peak power abs(sig).^2 of the input field is
% centered at the middle of the time window, i.e. at sample 
% n = nsamples/2 +  1
% where nsamples is the total number of samples in sig. nsamples is assumed
% to be an even number.
% It also normalises sig so that
% sig(nsamples/2 + 1) = 1
% i.e. the peak power at the center of the time window is equal to 1 and
% the phase is equal to zero.
% 
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% tfield = normalise_field(tfield);
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% sig               field to normalise [complex vector]
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% sig               normalised field [complex vector]
%                       We have sig(nsamples/2 + 1) = 1
%
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

nsamples = length(sig);

if rem(nsamples,2)
    error('normalise_field: number of samples of the input field should be even.')
end
% Check that the number of samples is an even number

[~,imax] = max(abs(sig).^2);
% Determine the sample corresponding to the peak power

sig = circshift(sig,[0 nsamples/2 + 1 - imax])/sig(imax);
% Retime and normalise the output field

end