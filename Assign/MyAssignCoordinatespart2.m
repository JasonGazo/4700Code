function MyAssignCoordinatespart2( num, w, l ,vth,deltaT,m,k,T)

%MyAssignCoordinates
vertarray=rand(num,1)*w;
horarray=rand(num,1)*l;

%Maxwell Distribution
Maxwell=@(v) sqrt(m/(2*pi*k*T))*exp(-m*(v^2)/(2*k*T));

%Selecting trajectory for each particle


vx=randn(num,1).*vth/sqrt(2);
vy=randn(num,1).*vth/sqrt(2);
vrms=sqrt(vx.^2+vy.^2);


count=0;
total=0;
numberofCol=0;
check=0;
sumtemp=0;

for i=1:400
     
    horarray(horarray>=l)=horarray(horarray>=l) - l;
    horarray(horarray<=0)=horarray(horarray<=0)+l;
    
    IT=[vertarray>=w];
    vy(IT)=-vy(IT);
    IT=[vertarray<=0];
    vy(IT)=-vy(IT);
    
    horarray=horarray+vx.*deltaT;
    vertarray=vertarray+vy.*deltaT;
    
    
    
    %scattering
    pscat=1-exp(-deltaT/(0.2*10^-12));
    a=rand();
    if (a<pscat)
        check=1;
        numberofCol=numberofCol+1;
        diff=i-count;
        count=i;
        timebtwCol=diff*deltaT;
        
        total=total+timebtwCol;
        avgTime=total/numberofCol;
        ave=mean(vrms);
        averageMFP=avgTime*ave;
        
        vx=randn(num,1).*vth/sqrt(2);
        vy=randn(num,1).*vth/sqrt(2);
        vrms=sqrt(vx.^2+vy.^2);
    end
   % scattering finished 
    
   
   %resolving for temperature
        
   Temp=m*mean(vrms.^2)/k;
   %ending of temp
    
   
   sumtemp=sumtemp+Temp;
   avgtemp=sumtemp/i;
   
   
   
   subplot(3,1,2)
   plot(i*deltaT,Temp,'+')
   title(['Temperature (Average Temp=' num2str(avgtemp),'kelvin)']);
   ylabel('Temperature')
   xlabel('Time')
   hold on
   
   subplot(3,1,1)
   plot(horarray,vertarray,'.')
   if(check==1)
       title(['Movement of Electrons (MFP=' num2str(averageMFP),'meters)']);
   else
       title('Movement of Electrons')
   end
    xlim([0 l])
    ylim([0 w])
    hold on 
    pause(.01)
    
    subplot(3,1,3)
    hist(vrms,10)
    title('Velocity Hist')
    xlabel('Velocity')
    ylabel('Freq')
    
end


fprintf('The estimated temperature is %6.4f kelvin \n',avgtemp)
fprintf('The estimated mean free path is %6.4f e-08 meter \n',averageMFP*10^8)
fprintf('The estimated mean time between collisions is %6.4f e-12 seconds \n',avgTime*10^12)
end
