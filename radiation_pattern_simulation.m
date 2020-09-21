clc;
clear;
close all;
s = []
for theta = -pi/2:0.01:pi/2
    %theta = [-pi/2:0.01:pi/2];
    for phi = -pi/6:0.01:pi/6
        for theta_s = -pi/2:0.01:pi/2
            for phi_s = -pi/6:0.01:pi/6
                f = 30e9;
                lambda = (3e8/f);
                dx = lambda/2;
                dy = lambda/2;
                M = 2;
                N = 2;
                u = sin(theta) .* cos(phi);
                v = sin(theta).*sin(phi);
                us = sin(theta_s) .* cos(phi_s);
                vs = sin(theta_s).*sin(phi_s);
                si_x = 2.*pi.*(dx./lambda).*(u-us);
                si_y = 2.*pi.*(dy./lambda).*(v-vs);
                s_x = sin((M.*si_x)./2)./(sin(si_x./2));
                s_y = sin((N.*si_y)./2)./(sin(si_y./2));
                s = s_x.*s_y;
                s = [s s];
            end
        end
    end
end
