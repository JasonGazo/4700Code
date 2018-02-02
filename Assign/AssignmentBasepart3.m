clc;
clear;
%% Assignment 1 part 3 - Enhancements (script)
%effective mass of electrons
%rest mass mo in kg
mo=9.109e-31;
me=0.26*mo;
%boltzman constant
kb=1.38064e-23;
%Nominal Size of region is 200nm x 100nm
T=300;

%1
vth=@(t) sqrt(kb*t/me);
vt=vth(300);
fprintf('The expected thermal velocity is %6.4f m/s \n',vth(300))
fprintf('The expected mean time between collisions is 0.2 e-12 seconds \n')

%2
%mean time collisions is 0.2 ps
tmn=0.2*10^-12;
%mean free path
mnfreepath=tmn*vth(300);
fprintf('The expected meanfreepath is %6.4f e-08 meters \n',mnfreepath*10^8)
fprintf('-------------------------------------------------------------\n')

%3
VMaxDim=200*10^-9;
VMinDim=0;
HMinDim=0;
HMaxDim=100*10^-9;
deltaT=7.562*10^-15;

%4
%Number of particles =20 for this simulation
MyAssignCoordinatespart3(50,VMaxDim,HMaxDim,vth(300), deltaT,me,kb,T)
