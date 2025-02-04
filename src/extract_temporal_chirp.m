function [phi,tcc,cc] = extract_temporal_chirp(t,field)
% Extraction of phase and temporal chirp from pulse field  
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function returns the temporal phase and frequency chirp from the
% field of a pulse specified in the time domain.
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% [tphi,time_chirp,tchirp] = extract_temporal_chirp(time_array,tfield);
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% t                 time values at which the input field is specified, in s 
%                       [real vector]
%
% field             pulse field [complex vector]
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% phi               pulse temporal phase [real vector]
%                       We stick to the convention exp(-1i*phi(t))
%
% tcc               time values at which the frequency chirp is calculated,
%                       in s [real vector]
%
% cc                frequency chirp, in Hz [real vector]
%                       
%                       Defined as df = - 1/(2*pi) dphi(t) / dt
% 
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

phi = -unwrap(angle(field));
% Extract phase. The limit is that of the unwrap function...

[tcc,cc] = num_diff(1,t,phi); 
% Differentiate the phase with respect to time

cc = - cc/2/pi;
% Frequency chirp

end