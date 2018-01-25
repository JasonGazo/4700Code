n = 50;
XY = 10 * rand(2,n) - 5;
for i=1:n
    comet(XY(1,i),XY(2,i),0.5)
    %,'or','MarkerSize',5,'MarkerFaceColor','r')
    axis([-5 5 -5 5])
    pause(.1)
end