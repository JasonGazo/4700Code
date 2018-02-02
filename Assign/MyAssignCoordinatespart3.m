function MyAssignCoordinatespart3( num, l, w ,vth,deltaT,m,k,T)
%%Publishing Part 3 of Assignment 1- Enhancements (Function)
%MyAssignCoordinates

%The vertical and horizontal coordinate for each particle is generated
vertarray=rand(num,1)*w;
horarray=rand(num,1)*l;

%The boundaries of the two squares can be specular (==1) or diffusive (==0)
specbounds=1;

%1. This loop ensures of the no particles are initialized inside the two
%squares
good=0;
while(good==0)
    x=((horarray<1.1*l/2 & horarray>0.9*l/2) & (vertarray<w/3 | vertarray>2*w/3));
        vertarray(x)=rand()*w;
        horarray(x)=rand()*l;
        if(sum(x)==0)
            good=1;
        end
end

%Two arrays are used to store each particles previous coordinate
prh=horarray();
prv=vertarray();


%Maxwell Distribution in MATLAB function form
Maxwell=@(v) sqrt(m/(2*pi*k*T))*exp(-m*(v^2)/(2*k*T));

%Array of random velocities for each particle
vx=randn(num,1).*vth/sqrt(2);
vy=randn(num,1).*vth/sqrt(2);

%Array will store the total velocity of each particle
vrms=sqrt(vx.^2 + vy.^2);

%counters and sums for 'average-particle calculations' in the for-loop
count=0;
total=0;
numberofCol=0;
check=0;
sumtemp=0;

%movie runs
for i=1:400
    horarray(horarray>=1)=horarray(horarray>=1)-l;
    horarray(horarray<=0)=horarray(horarray<=0)+l;
    
    IT=[vertarray>=w];
    vy(IT)=-vy(IT);
    IT=[vertarray<=0];
    vy(IT)=-vy(IT);
    
    prh=horarray();
    prv=vertarray();
    
    horarray=horarray+vx.*deltaT;
    vertarray=vertarray+vy.*deltaT;
    
    x=((horarray<1.1*l/2 & horarray>0.9*l/2) &(vertarray<w/3 | vertarray>2*w/3));
    
    if(specbounds==1 & sum(x)~=0)
        if((prh(x)<1.1*l/2 & prh(x)>0.9*l/2))
            vy(x)=-vy(x);
        else
            vx(x)=-vx(x);
        end
    elseif(specbounds==0 && sum(x)~=0)
        if((prh(x)<1.1*l/2 & prh(x)>0.9*l/2) & vy(x)>0)
            vertarray(x)=vertarray(x)-2*(vertarray(x)+2*w/3);
            vx(x)=randn().*vth/sqrt(2);
            vy(x)=-abs(randn().*vth/sqrt(2));
        elseif((prh(x)<1.1*l/2 & prh(x)>0.9*l/2) & vy(x)<0)
            vertarray(x)=vertarray(x)+2*(w/3-vertarray(x));
            vx(x)=randn().*vth/sqrt(2);
            vy(x)=abs(randn().*vth/sqrt(2));
        elseif(vx(x)>0)
            horarray(x)=horarray(x)-2*(horarray(x)-0.9*l/2);
            vx(x)=-abs(randn().*vth/sqrt(2));
            vy(x)=randn().*vth/sqrt(2);
        else
            horarray(x)=horarray(x)+2*(1.1*l/2-horarray(x));
            vx(x)=abs(randn().*vth/sqrt(2));
            vy(x)=abs(randn().*vth/sqrt(2));
        end
        rms=sqrt(vx.^2+vy.^2);  
    end
    
    pscat=1-exp(-deltaT/(0.2*10^-12));
    a=rand();
    
    if(a<=pscat)
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
    %{
    Temp=m*mean(vrms.^2)/k;
    sumtemp=sumtemp+Temp;
    avgtemp=sumtemp/i;
    
    
    subplot(2,1,2)
    plot(i*deltaT,Temp,'+')
    title(['Temperature (Average Temp =' num2str(avgtemp),'kelvin)']);
    ylabel('Temperature (kelvin)')
    xlabel('Time')
    hold on
    
    subplot(2,1,1)
    %}
    plot(horarray, vertarray,'.')
    if(check==1)
        title(['Movement of Electrons (MFP=' num2str(averageMFP),'meters)']);
        
    else
        title('Movement of Electrons')
    end
    
    xlim([0 l])
    ylim([0 w])
    
    line([0.9*l/2 0.9*l/2],[w 2*w/3])
    line([1.1*l/2 1.1*l/2],[w 2*w/3])
    line([0.9*l/2 1.1*l/2],[w w])
    line([0.9*l/2 1.1*l/2],[2*w/3 2*w/3])
    
    line([0.9*l/2 0.9*l/2],[0 w/3])
    line([1.1*l/2 1.1*l/2],[0 w/3])
    line([0.9*l/2 1.1*l/2],[0 0])
    line([0.9*l/2 1.1*l/2],[w/3 w/3])
    hold on
    pause(0.01)
    
    
    
end

    figure (3)
    hist(vrms, 10)
    title('Velocity Histogram')
    xlabel('Velocity')
    ylabel('Frequency')



[binx,biny]=meshgrid(0:l/10:l,0:w/10:w);
zcheck=zeros(11,11);
tempcheck=zeros(11,11);
counter=0;
vtotal=0;

for i=1:10
    tempxmin=binx(1,i);
    tempxmax=binx(1,i+1);
    for r =1:10
        tempymin=biny(r,1);
        tempymax=biny(r+1,1);
        for mm=1:num
            if((horarray(mm)>tempxmin & horarray(mm)<tempxmax) & vertarray(mm)<tempymax & vertarray(mm)>tempymin)
                counter=counter+1;
                zcheck(i,r)=zcheck(i,r)+1;
                vtotal=vtotal+sqrt(vx(mm)^2+vy(mm)^2);
                tempcheck(i,r)=m*(vtotal^2)/(counter*k);
                
            end
        end
       vtotal=0;
       counter=0;
    end
end

figure(5)
surf(binx,biny,zcheck)
title('Final Position Electron Density Map')
zlabel('Number of Electrons in Section')

figure(6)
surf(binx,biny,tempcheck)
title('Final Temperature Density Map')
zlabel('Temperature in Section')

%fprintf('The estimated temperature is %6.4f kelvin \n',avgtemp)
fprintf('The estimated mean free path is %6.4f e-08 meter \n',averageMFP*10^8)
fprintf('The estimated mean time between collisions is %6.4f e-12 seconds \n',avgTime*10^12)
end

        
    
    

