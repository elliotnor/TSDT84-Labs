function [xq] = MS8P1(x,xmax,b,method);
% MS8P1.m : MATLAB Session 8, Program 1
% Function M-file quantizes x over (-xmax,xmax) using 2^b levels.
% Both symmetric and asymmetric quantization are supported.
% INPUTS:   x = input signal
%           xmax = maximum magnitude of signal to be quantized
%           b = number of quantization bits
%           method = default 'sym' for symmetrical, 'asym' for asymmetrical
% OUTPUTS:  xq = quantized signal
if (nargin<3),
    disp('Insufficient number of inputs.'); return
elseif (nargin==3),
    method = 'sym';
elseif (nargin>4),
    disp('Too many inputs.'); return
end

switch lower(method)
    case 'asym'
        offset = 1/2;
    case 'sym'
        offset = 0;
    otherwise
        disp('Unrecognized quantization method.'); return
end
q = floor(2^b*((x+xmax)/(2*xmax))+offset);
i = find(q>2^b-1); q(i) = 2^b-1;
i = find(q<0); q(i) = 0;
xq = (q-(2^(b-1)-(1/2-offset)))*(2*xmax/(2^b));
output=xq;