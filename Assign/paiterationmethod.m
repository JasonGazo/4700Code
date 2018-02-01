%start of pa 2
w=10;
le=10;

[x,y]=meshgrid(0:w/w:w,0:le/le:le);

g=zeros(w,le);


for m=1:100
        figure(1)
        surf(g)
        
        pause(0.01)
        
        
    for i=1:w
    
    
        for r = 1:le
            if(i==1)
                g(r,i)=1;
            elseif(i==w)
                g(r,i)=1;
            elseif(r==1)
                g(r,i)=0;
            elseif(r==le)
                g(r,i)=0;
            else
                
                    g(r,i)=averageflow(g(r,i-1),g(r,i+1),g(r-1,i),g(r+1,i),4);
                
            end
            
        end
    end  
end