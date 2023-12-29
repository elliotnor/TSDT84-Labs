% MS2P3.m : MATLAB Session 2, Program 3
% Script M-file determines characteristic roots over
% a range of component values.

% Pre-allocate memory for all computed roots:
lambda = zeros(2,243);
% Initialize index to identify each permutation:
p=0;
for R1 = 1e4*[0.9,1.0,1.1],
    for R2 = 1e4*[0.9,1.0,1.1],
        for R3 = 1e4*[0.9,1.0,1.1],
            for C1 = 1e-9*[0.75,1.0,1.25],
                for C2 = 1e-6*[0.75,1.0,1.25],
                    p = p+1;
                    lambda(:,p) = MS2P2([R1 R2 R3],[C1 C2]);
                end
            end
        end
    end
end

plot(real(lambda(:)),imag(lambda(:)),'kx',...
    real(lambda(:,1)),imag(lambda(:,1)),'kv',...
    real(lambda(:,end)),imag(lambda(:,end)),'k^')
xlabel('Real'),ylabel('Imaginary')
legend('Characteristic Roots','Min-Component Values Roots','Max-Component Values Roots',0);

output=lambda;
