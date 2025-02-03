function field = pulse_sech(t,pp,tfwhm,b,c,q)
% Generate hyperbolic secant pulse with various temporal chirp profiles
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function generates the complex field of a hyperbolic secant pulse 
% with various temporal chirp profiles.
% Those include:
% 1. linear temporal chirp (quadratic temporal phase)
% 2. quadratic temporal chirp (cubic temporal phase)
% 3. "self-phase modulation chirp" (temporal phase proportional to the
%    square modulus of the field).
% The generated pulse field takes the form
% e(t) = e0 sech(t/t0) exp(-j phi(t)), where
% - e0^2 is the peak power
% - to is linked to the pulse full-width at half-maximum tfwhm according to 
%   t0 = tfwhm / 2*log(1 + sqrt(2))
% - phi(t) = -b*t^2 - c*t^3 + q*e^2(t)
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% tfield = pulse_sech(time_array,pp,tfwhm,b,c,q)
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% t                 time values at which the pulse field will be evaluated
%                       [real vector]
% 
% pp                pulse peak power [real scalar]
%
% tfwhm             pulse duration expressed in term of full-width at
%                       half-maximum [real scalar]
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
t0 = tfwhm /2/log(1 + sqrt(2));
% Convert full-width at half-maximum to t0 parameter.

field = sqrt(pp)*sech(t/t0);
% sech envelope.

phase = -b*t.^2 - c*t.^3 + q*abs(field).^2;
% Temporal phase including quadratic and cubic terms + intensity-dependent
% phase (self-phase modulation type).

field = field.*exp(-1j*phase);
% Total field.

end
% -------------------------------------------------------------------------
% End of function
% -------------------------------------------------------------------------