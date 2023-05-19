%% 1D Steady Flow Simulation between two plates
clear;
clc;
%% User input
u1=input('Enter the base plate boundary velocity');
u4=input('Enter the upper plate boundary velocity');
L=input('What''s the distance between two plates?');
nx=input('How many number of grid points do you want?');
delx=L/(nx-1);
mu=input('Provide the dynamic viscosity of the fluid');
dpdx=input('Provide the pressure gradient');
%% Solver
D=(delx*dpdx)/mu;
y=0:delx:L;
dist=y';
%% Creating Matrix Definition
p(1,1)=1;
p(1,2:nx)=0;
q(1,nx)=1;
q(1,1:nx-1)=0;
r=toeplitz([2 -1 zeros(1,nx-4)]);
s(1,1)=-1;
s(2:nx-2,1)=0;
t(nx-2,1)=-1;
t(1:nx-3,1)=0;
A(1,:)=p;
A(nx,:)=q;
A(2:nx-1,1)=s;
A(2:nx-1,nx)=t;
A(2:nx-1,2:nx-1)=r;
B(1,1)=u1;
B(nx,1)=u4;
B(2:nx-1,1)=D;
%% Creating Matrix Equation
V=inv(A)*B;
%% Plotting of Flow Profile
plot(V,dist);
xlabel('Velocity of Flowing Fluid');
ylabel('Distance between the plates');
title(['Velocity Profile of Flowing Fluid between Two Parallel Plates']);
grid on;
%% End of MATLAB Program