%% RK Stability Diagram
clear all;
clc;
[x,y] = meshgrid(-6:0.01:6,-6:0.01:6);
z = x+i*y;
R1 = 1+z;
zlevel = abs(R1);
contour(x,y,zlevel,[1 1],'LineWidth',1,'Color','k');
hold on;
R2 = 1+z+0.5*z.^2;
zlevel = abs(R2);
contour(x,y,zlevel,[1 1],'LineWidth',1,'Color','r');
hold on;
R3 = 1+z+0.5*z.^2+(1/6)*z.^3;
zlevel = abs(R3);
contour(x,y,zlevel,[1 1],'LineWidth',1,'Color','b');
hold on;
R4 = 1+z+0.5*z.^2+(1/6)*z.^3+(1/24)*z.^4;
zlevel = abs(R4);
contour(x,y,zlevel,[1 1],"LineWidth",1,'Color','g');
hold on;
R5 = 1+z+0.5*z.^2+(1/6)*z.^3+(1/24)*z.^4+(1/120)*z.^5;
zlevel = abs(R5);
contour(x,y,zlevel,[1 1],"LineWidth",1,'Color','c');
hold on;
R6 = 1+z+0.5*z.^2+(1/6)*z.^3+(1/24)*z.^4+(1/120)*z.^5+(1/720)*z.^6;
zlevel = abs(R6);
contour(x,y,zlevel,[1 1],"LineWidth",1,'Color','m');
hold on
xlabel('Real Axis');
ylabel('Imaginary Axis');
title(['RK Stability Diagram']);
legend('RK-1','RK-2','RK-3','RK-4','RK-5','RK-6');
%% End of MATLAB Program
