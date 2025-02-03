function [varphi,dff,grpdel] = extract_group_delay(ff,ffield)
% Extraction of spectral phase and group delay from field in frequency domain
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function returns the spectral phase and group delay from the
% field of a pulse specified in the frequency domain.
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% ffield = num_ft(tfield,dt,0);
% [varphi,freq_del,grpdelay] = extract_group_delay(frequency_array,ffield);
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% ff                relative frequency values at which the input field is 
%                       specified, in Hz [real vector]
%
% ffield            pulse field in the spectral domain [complex vector]
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% varphi            pulse spectral phase [real vector]
%                       We stick to the convention exp(-1i*varphi(w))
%
% dff               relative frequency values at which the group delay is 
%                       calculated, in Hz [real vector]
%
% grpdel            group delay, in s [real vector]
%                       
%                       Defined as grpdel =  dvarphi(w) / dw
%                                         = 1/2/pi dvarphi/df
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

varphi = -unwrap(angle(ffield));
% Extract spectral phase. The limit is that of the unwrap function...

[dff,grpdel] = num_diff(1,ff,varphi);
% Differentiate spectral phase with respect to frequency.

grpdel = grpdel/2/pi;
% Group delay

end
% -------------------------------------------------------------------------
% End of function
% -------------------------------------------------------------------------