h = animatedline;
axis tight equal

x = linspace(0,4*pi,1000);
y =sin(x)+cos(x)+x+0.2.^x;
for k = 1:length(x)
    addpoints(h,x(k),y(k));
    drawnow
end