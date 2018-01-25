function MyAssignCoordinates( kb,m,num, w, l ,vth,deltaT)
%MyAssignCoordinates
vertarray=rand(num,1)*w;
horarray=rand(num,1)*l;
vertarrayp=vertarray;
horarrayp=horarray;

%xlim(l);
%ylim(w);
%establish velocity and angles
angles=rand(num)*2*pi;
vx=ones(num,1);
vy=ones(num,1);
vrms=ones(num,1);

Temp=(1:1000);




for i=1:num
    vx(i)=cos(angles(i))*vth;
    vy(i)=sin(angles(i))*vth;
end

for i=1:1000
    %horizontal periodic boundary generator
    horarray(horarray>=l)=horarray(horarray>=l) - l;
    horarray(horarray<=0)=horarray(horarray<=0)+l; 
    %vertical reflection boundary generator
    IT=[vertarray>=w];
    vy(IT)=-vy(IT);
    IT=[vertarray<=0];
    vy(IT)=-vy(IT);
    %Temperature Checker
    vrms=sqrt((sum(vx)/num)^2+(sum(vy)/num)^2)
    Temp=m*vrms/kb;
    %end temp plot attempt
    
    horarray=horarray+vx.*deltaT;
    vertarray=vertarray+vy.*deltaT;
    plot(horarray,vertarray,'.')
    
    hold on 
    pause(.01)
end






end
