function MyAssignCoordinatespart2( num, w, l ,vth,deltaT,m,k,T)

%MyAssignCoordinates
vertarray=rand(num,1)*w;
horarray=rand(num,1)*l;

%Maxwell Distribution
Maxwell=@(v) sqrt(m/(2*pi*k*T))*exp(-m*(v^2)/(2*k*T));

%Selecting trajectory for each particle
angles=rand(num)*2*pi;

%Array of Velocities
vx=ones(num,1);
vy=ones(num,1);
vrms=ones(num,1);
freqx=rand(num,1)*Maxwell(0);
freqy=rand(num,1)*Maxwell(0);
for i =1:num
    vx(i)=InitializedVelocityKB(freqx(i),m,T,k);
    vy(i)=InitializedVelocityKB(freqy(i),m,T,k);
end
hist(vy,10)
for i=1:num
    vx(i)=cos(angles(i))*vx(i);
    vy(i)=sin(angles(i))*vy(i);
end
figure(2)
for i=1:1000
     
    horarray(horarray>=l)=horarray(horarray>=l) - l;
    horarray(horarray<=0)=horarray(horarray<=0)+l;
    IT=[vertarray>=w];
    vy(IT)=-vy(IT);
    
    %scattering
    pscat=1-exp(-deltaT/(0.2*10^-12));
    a=rand();
    if (a<pscat)
        freqx=rand(num,1)*Maxwell(0);
        freqy=rand(num,1)*Maxwell(0);
        for r=1:num
            vx(r)=InitializedVelocityKB(freqx(r),m,T,k);
            vy(r)=InitializedVelocityKB(freqy(r),m,T,k);
        end
        
        angles=rand(num)*2*pi;
        for r=1:num
             vx(r)=cos(angles(r))*vx(r);
             vy(r)=sin(angles(r))*vy(r);
        end
    end
   % scattering finished 
    
   
   %resolving for temperature
        vrms=sqrt((sum(vx)/num)^2+(sum(vy)/num)^2);
        Temp=m*vrms/k;
   %ending of temp
    IT=[vertarray<=0];
    vy(IT)=-vy(IT);
    horarray=horarray+vx.*deltaT;
    vertarray=vertarray+vy.*deltaT;
    plot(horarray,vertarray,'.')
    xlim([0 l])
    ylim([0 w])
    hold on 
    pause(.01)
end
end
