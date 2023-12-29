a = -3; b = 4;
        [theta,C] = cart2pol(a,-b);
        theta_deg = (180/pi)*theta;
        disp(['C = ',num2str(C),'; theta = ',num2str(theta),...
                '; theta_deg = ',num2str(theta_deg)]); 

output1=C;
output2=theta;
output3=theta_deg;