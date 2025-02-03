function field = pulse_gauss(t,pp,a,b,c,q)
% Generate Gaussian pulse with various temporal chirp profiles
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function generates the complex field of a Gaussian pulse with
% various temporal chirp profiles.
% Those include:
% 1. linear temporal chirp (quadratic temporal phase)
% 2. quadratic temporal chirp (cubic temporal phase)
% 3. "self-phase modulation chirp" (temporal phase proportional to the
%    square modulus of the field).
% The generated pulse field takes the form
% e(t) = e0 exp(-a t^2) exp(-j phi(t)), where
% - e0^2 is the peak power
% - a is linked to the pulse full-width at half-maximum according to 
%   a = 2*ln(2)/t_fwhm^2, where t_fwhm is the full-width at half-maximum.
% - phi(t) = -b*t^2 - c*t^3 + q*e^2(t)
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% tfield = pulse_gauss(time_array,pp,a,b,c,q);
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% t                 time values at which the pulse field will be evaluated
%                       [real vector]
% 
% pp                pulse peak power [real scalar]
%
% a                 pulse duration parameter [real scalar]
%
%                       The modulus of the field assumes the shape
%                           |e(t)| = sqrt(pp)*exp(-a*t^2)
%                       and therefore a is linked to the pulse full-width
%                       at half-maximum according to
%                           a = 2*ln(2)/t_fwhm^2
%
% b                 linear chirp parameter [real scalar]
%
%                       The phase term corresponding to linear chirp is 
%                           phi(t) = - b*t^2
%
% c                 quadratic chirp parameter [real scalar]
%
%                       The phase term corresponding to quadratic chirp is
%                           phi(t) = - c*t^3
% 
% q                 self-phase modulation chirp parameter
%
%                       The phase term corresponding to SPM chirp is
%                           phi(t) = +q*|e(t)|^2
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% field             generated field [complex vector]
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

field = sqrt(pp)*exp(-a*t.^2);
% Gaussian envelope.

phase = -b*t.^2 - c*t.^3 + q*abs(field).^2;
% Temporal phase including quadratic and cubic terms + intensity-dependent
% phase (self-phase modulation type).

field = field.*exp(-1j*phase);
% Total field.

end
% -------------------------------------------------------------------------
% End of function
% -------------------------------------------------------------------------