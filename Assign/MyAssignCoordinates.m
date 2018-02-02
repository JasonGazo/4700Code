function MyAssignCoordinates( kb,m,num, w, l ,vth,deltaT)
%MyAssignCoordinates
vertarray=rand(num,1)*w;
horarray=rand(num,1)*l;

%xlim(l);
%ylim(w);
%establish velocity and angles
angles=rand(num)*2*pi;
vx=ones(num,1);
vy=ones(num,1);
vrms=ones(num,1);

for i=1:num
    vx(i)=cos(angles(i))*vth;
    vy(i)=sin(angles(i))*vth;
end

sumtemp=0;
for i=1:400
    
    %horizontal periodic boundary generator
    horarray(horarray>=l)=horarray(horarray>=l) - l;
    horarray(horarray<=0)=horarray(horarray<=0)+l; 
    
    %vertical reflection boundary generator
    IT=[vertarray>=w];
    vy(IT)=-vy(IT);
    IT=[vertarray<=0];
    vy(IT)=-vy(IT);
    %Temperature Checker
    vrms=sqrt((sum(abs(vx))/num)^2+(sum(abs(vy))/num)^2);
    Temp=m*mean(vrms.^2)/kb;
    %end temp plot attempt
    sumtemp=sumtemp+Temp;
    avgtemp=sumtemp/i;
    
    subplot(2,1,2)
    plot(i*deltaT,Temp,'+')
    title('Temperature over Time')
    ylabel('Temperature (kelvin)')
    xlabel('Time')
    ylim([0 Temp+Temp*1.25])
    hold on
    
    
    horarray=horarray+vx.*deltaT;
    vertarray=vertarray+vy.*deltaT;
   
    
    subplot(2,1,1)
    plot(horarray,vertarray,'.')
    title('Movement of Electrons')
    xlim([0 l])
    ylim([0 w])
    
    hold on 
    pause(.01)
end






end