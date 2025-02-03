function [ifrog,esigw] = frog_trace(sig,gate)
% Spectrogram of an optical field with arbitrary gate function
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function calculates the spectrogram of an optical field e(t)
% according to:
% ifrog(w,tau)=|\int e(t) g(t - tau) e^{-jwt) dt|^2
% where w is the angular frequency and tau a delay. The integration is
% performed from minus to plus infinity, or in our case over one time
% window corresponding to one period of the signal.
% This definition is compatible with our signal representation and
% corresponds to the one in:
% Rick Trebino, "Frequency-resolved optical gating: the measurement of
% ultrashort laser pulses", Kluwer Academic Publisher, 2000
% pp. 11-12 for the definition of the field and the complex envelope
% p. 102 for the definition of the spectrogram.
% The integration corresponds to the Fourier transform of the function
% e(t)*g(t-tau) by the matlab fft function.
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% 
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% sig               electric field to analyse e(t) [complex vector]
%                      
% gate              gate function g(t) [complex vector]
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% ifrog             spectrogram [real matrix]
%                       The spectrogram is normalised to a maximum value 
%                       of 1.
%
% esigw             field of the spectrogram [complex matrix]
%                       Corresponds to 
%                           esig(w,\tau) = int e(t) g(t - \tau) e^{-jwt} dt
%                       according to the notations by Trebino.
%                   
%                       The spectrogram is defined as
%                           ifrog = abs(esigw).^2;
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
% The method employed to calculate the spectrogram is strongly inspired by
% the "Frequency-resolved optical gating (FROG)" package by Adam Wyatt
% available on Matlab central at
% http://www.mathworks.com/matlabcentral/fileexchange/16235-frequency-resolved-optical-gating-frog
% [Accessed 2011-08-12].
%
% -------------------------------------------------------------------------
% AUTHOR:
% -------------------------------------------------------------------------
% Christophe Peucheret (christophe.peucheret@univ-rennes.fr) 
%
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

sig = sig(:);
% Force the signal to a column vector.
gate = gate(:);
% Force the gate to a column vector.

nsamples = length(sig);
% Number of samples in the signal.

if nsamples ~= length(gate)
    error('frog_trace: the signal and the gate should have the same length.');
end
% The signal and the gate should have the same length.

esig = sig*gate.';
% Create matrix esig_ij= (sig(i) * gate(j)

for ii = 1:nsamples
    esig(ii,:) = fliplr(fftshift(circshift(esig(ii,:),[0 1 - ii]),2));
end
% circshift(esig(ii,:),[0 1 - ii]) consists of:
% column 1: signal * gate [e(t)*g(t)]
% column 2: signal * gate advanced by 1 time sample [e(t)*g(t + dt)]
% column 3: signal * gate advanced by 2 time samples [e(t)*g(t + 2*dt)]
% ...
% column nsamples - 1: signal * gate advanced by nsamples - 2 time samples
% [e(t)*g(t + (nsamples - 2)*dt)]
% column nsamples: signal * gate advanced by nsamples - 1 time samples
% [e(t)*g(t + (nsamples - 1)*dt)]
% The first nsamples/2 columns correspond to delays of:
% 0 -dt -2*dt ... (-nsamples/2 - 1)*dt
% The last nsamples/2 correspond to delays of:
% -nsamples/2*dt ... -(nsamples - 1)*dt
% which, by virtue of the cyclic properties of the signal, also correspond
% to delays of
% nsamples/2*dt ... dt
% We then reorder the columns by fftshift( ,2) so that they become in
% decreasing delay order:
% nsamples/2*dt ... 0 ... -nsamples/2*dt
% Finally, we flip them using fliplr so that they become in increasing
% delay order.
% We finally end up with Esig(t,tau), according to the usual notations by
% Trebino, where Esig(t,tau) = E(t) * g(t - tau).
% Next step it to perform calculate the Fourier transform along the lines
% to obtain ~Esig(w,\tau)

esigw = fftshift(fft(esig,[],1),1)/nsamples;

ifrog = abs(esigw).^2;
% FROG trace.

spmax = max(ifrog,[],'all');
ifrog = ifrog/spmax;
% Normalise FROG trace




end
% -------------------------------------------------------------------------
% End of function
% -------------------------------------------------------------------------