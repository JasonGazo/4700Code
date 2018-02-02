clc
%Start of assignment 1
%effective mass of electrons =mn
%rest mass mo in kg
mo=9.109*10^-31;
me=0.26*mo;
%botlzman constant
kb=1.38064*10^-23;
%Nominal size of region is 200nmx100nm

%1

vth=@(t) sqrt(kb*t/me);
vt=vth(300);
fprintf('The expected thermal velocity is %6.4f m/s \n',vth(300))
fprintf('The expected mean time between collisions is 0.200e-12\n')

%2
%mean time collisions is 0.2 ps
tmn=0.2*10^-12;
%mean free path
mnfreepath=tmn*vth(300);
fprintf('The expected mean free path is %6.4f e-08 meters\n',mnfreepath*10^8)
fprintf('-----------------------------------------------------------\n')
%3
VMaxDim=200*10^-9;
VMinDim=0;
HMinDim=0;
HMaxDim=100*10^-9;
%4
deltaT=7.562*10^-15;
MyAssignCoordinates(kb,me,10,VMaxDim,HMaxDim,vth(300),deltaT)