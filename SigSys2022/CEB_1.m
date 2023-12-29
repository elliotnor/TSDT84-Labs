% (a)
        [z_rad,z_mag] = cart2pol(2,3);
        z_deg = z_rad*(180/pi);
        disp(['(a) z_mag = ',num2str(z_mag),'; z_rad = ',num2str(z_rad),...
                '; z_deg = ',num2str(z_deg)]);

output1=z_mag;
output2=z_rad;
output3=z_deg;

        % (b)
        [z_rad,z_mag] = cart2pol(-2,1);
        z_deg = z_rad*(180/pi);
        disp(['(b) z_mag = ',num2str(z_mag),'; z_rad = ',num2str(z_rad),...
                '; z_deg = ',num2str(z_deg)]);

output4=z_mag;
output5=z_rad;
output6=z_deg;