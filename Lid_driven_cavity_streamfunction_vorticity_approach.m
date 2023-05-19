%% Lid Driven Cavity by Vorticity-Stream Function Approach
clear;
clc;
fprintf('This is a non-parametric program. So please provide data in same system of measurement.\n');
%% User Inputs
fprintf('This program is developed for square cavity and having uniform mesh criterion.\n');
l=input('Please provide the length of cavity.\n');
nx=input('Please provide number of nodes you want.\n');
ny=nx;
Re=input('Provide the Reynolds number for the flow.\n');
dx=l/(nx-1);
dy=l/(ny-1);
fprintf('Please refer https://www.engineeringtoolbox.com for properties of fluid\n');
nu=input('Provide the kinematic viscosity of the fluid.\n');
rho=input('Provide the density of fluid.\n');
U=Re*(nu/l);
err=input('What''s the residual limit for covergence you want?\n');
%% Memory Allocation for Variables
si=zeros(nx,ny);
w=zeros(nx,ny);
u=zeros(nx,ny);
v=zeros(nx,ny);
p=zeros(nx,ny);
%% Solver
%% Stream Function Solver
for it=1:1000
    for k=1:1000
        tempvalue1=si;
            for i=2:nx-1
                for j=2:ny-1
                    si(i,j)=(0.25)*(((dx^2)*w(i,j))+ si(i,j+1)+ si(i,j-1)+si(i+1,j)+si(i-1,j));
                end
            end
        %% Convergence Criterion Check for stream function
        if abs(tempvalue1-si)<=err;
        break;
    end
end
%% Vorticity Solver
tempvalue2=w;
for i=2:nx-1
    for j=2:ny-1
        w(i,j)=((0.25)*(w(i,j+1)+w(i,j-1)+w(i+1,j)+w(i-1,j)))-((0.25*dx/nu)*((si(i+1,j)-si(i-1,j))/2)*((w(i,j+1)-w(i,j-1))/2))+((0.25*dx/nu)*((si(i,j+1)-si(i,j-1))/2)*((w(i+1,j)-w(i-1,j))/2));
    end
end
%% Boundary Condition for vorticity wrt stream function
w(ny,:)=((2/(dx*dx))*(si(ny,:)-si(ny-1,:)))-(2*U/dx);
w(1,:)=(2/(dx*dx))*(si(1,:)-si(2,:));
w(:,nx)=(2/(dx*dx))*(si(:,nx)-si(:,nx-1));
w(:,1)=(2/(dx*dx))*(si(:,1)-si(:,2));
si(:,nx)=0;
si(:,1)=0;
si(1,:)=0;
si(ny,:)=0;
%% Convergence Criterion Check for vorticity
    if abs(tempvalue2-w)<=err;
    break;
    end
end
%% Boundary Condition for vorticity wrt velocity
u(1,:)=0;
v(1,:)=0;
u(ny,:)=U;
v(ny,:)=0;
u(:,1)=0;
v(:,1)=0;
u(:,nx)=0;
v(:,nx)=0;
%% Intermediate Velocity Solver
for i=2:nx-1
    for j=2:ny-1
        u(i,j)=(si(i,j+1)-si(i,j-1))/(2*dy);
        v(i,j)=-(si(i+1,j)-si(i-1,j))/(2*dx);
    end
end
%% Pressure Solver
for k=1:1000
    tempvaluep=p;
    for i=2:nx-1
        for j=2:ny-1
            p(i,j)=((0.25)*(p(i,j+1)+p(i,j-1)+p(i+1,j)+p(i-1,j)))-((rho/(2*dx*dx))*(si(i,j+1)-2*si(i,j)+si(i,j-1))*(si(i+1,j)-2*si(i,j)+si(i-1,j)))+(((rho)/(32*dx*dx))*((si(i+1,j+1)-si(i-1,j+1)-si(i+1,j-1)+si(i-1,j-1))^2));
        end
    end
    %% Convergence Criterion Check for Pressure
    if abs(tempvaluep-p)<=err;
        break;
    end
end
%% Plotting Parameters
figure(1);
plot(linspace(0,1,nx),v((ny/2)+0.5,:),'LineWidth',3);
xlabel('X-direction');
ylabel('v-velocity');
title('X-direction vs V velocity');
figure(2);
plot(u(:,(nx/2)+0.5),(linspace(0,1,ny)),'LineWidth',3);
xlabel('U-velocity');
ylabel('Y-direction');
title(' U velocity vs Y-direction');
figure(3);
contour(w);
xlabel('nx');
ylabel('ny');
title('Vorticity');
axis('square','tight');
colorbar;
title('Vorticity');
figure(4);
contour(si);
xlabel('nx');
ylabel('ny');
title('Stream function');
axis('square','tight');
colorbar;
title('Stream Function');
figure(5);
contour(p,10000);
xlabel('nx');
ylabel('ny');
title('Pressure');
axis('square','tight');
colorbar;
%% End of MATLAB Program