 %OFElectron
    force=1;
    m=1;
    deltat=0.1;
    x=rand(10,1)*20;
    vx=zeros(10,1);
    figure (1)
   
    i=ones(10,1);
    for t = 1:1000
        
        
        p=0.05;
        m=rand()
        if m<p
            
            vx=0;
        
        end
        
        
        subplot(2,1,1)
        plot(i*t,x,'.')
        title("X vs Time")
        xlabel("time")
        ylabel("x")
        hold on
        accel=force/m;
        vx=vx+accel*deltat;
        x=x+vx*deltat;
       
        average=mean(vx)
        
        
        
       subplot(2,1,2);
       plot(i*t,vx,'.');
       title(['Velocity vs time (Drift Velocity =' num2str(average),')']);
       xlabel("time");
       ylabel("velocity");
       hold on
       pause(0.01)
    end
    