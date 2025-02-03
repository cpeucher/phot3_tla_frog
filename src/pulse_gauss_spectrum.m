function ffield = pulse_gauss_spectrum(f,pmax,bw,phi)
% Generate Gaussian pulse with specified spectral phase profile
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function generates the complex field of Gaussian pulse with spectral
% phase profile specified by the values of the coefficients of its Taylor 
% expansion with respect to angular frequency:
% phase(w) = phi(1)*(w -w0) + phi(2)*(w -w0)^2 / 2 + ... 
%                           + phi(n)*(w - w0)^n / n!
% where w is the angular frequency and w0 the reference frequency of the 
% simulation (i.e. the pulse spectrum is centered at a relative frequency
% of 0).
% The field is returned in the frequency domain. It is therfore necessary
% to execute a frequency-to-time conversion after calling this function in
% order to obtain a customarily defined time-domain field.
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% ffield = pulse_gauss_spectrum(frequency_array,pmax,bw,phi)
% tfield = num_ift(ffield,dt,0);
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% f                 relative frequency values at which the pulse field will
%                       be evaluated [real vector]
%
% pmax              maximum spectrum of the power (at f = 0), in W
%                       [real scalar]
%
% bw                full-width at half maximum spectral width, in Hz
%                       [real scalar]
%
% phi               coefficients of the Taylor expansion of the spectral 
%                       phase [real vector]
%
%                       The spectral phase is
%                       phase(w) = phi(1)*(w -w0) + phi(2)*(w -w0)^2 / 2 + 
%                           ... + phi(n)*(w - w0)^n / n!
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% ffield            generated field in the frequency domain 
%                       [complex vector]
%
% -------------------------------------------------------------------------
% GLOBAL:
% -------------------------------------------------------------------------
%
%
% -------------------------------------------------------------------------
% REMARKS:
% -------------------------------------------------------------------------
% 
%
% -------------------------------------------------------------------------
% TO DO:
% -------------------------------------------------------------------------
% 
%
% -------------------------------------------------------------------------
% CREDITS:
% -------------------------------------------------------------------------
% 
%
% -------------------------------------------------------------------------
% AUTHOR:
% -------------------------------------------------------------------------
% Christophe Peucheret (christophe.peucheret@univ-rennes1.fr)
%
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

spectral_phase = zeros(1,length(f));
for ii = 1:length(phi)
    spectral_phase = spectral_phase + phi(ii)*(2*pi*f).^ii / factorial(ii);
end
% Calculation of spectral phase.

w0 = pi*bw / sqrt(log(2));
% Half-bandwidth at 1/e intensity.

ffield = sqrt(pmax)*exp(-(2*pi*f).^2/w0^2/2).*exp(-1i*spectral_phase);
% Field in the frequency domain.

end
% -------------------------------------------------------------------------
% End of function
% -------------------------------------------------------------------------