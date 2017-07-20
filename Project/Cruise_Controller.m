clear all;
close all;

%% Car Model
% x_dot = (c/m)*u;
% aim: x->r , e->0 as t->infinity

%% System Properties
c = 10;
m = 10;     

%% state of system
x_old = 0;  %current state    
r = 17;     %desired state 
dt = 0.01;  %discrete time
t=0:dt:3;        %begin time
u_max = 10; %Control parameter

%% Control Loop
e = r - x_old;

%Create animation handles
v = VideoWriter('peaks.avi');
open(v);
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
title('Position')
xlabel('time(s)')
ylabel('Position')
h_x = animatedline('Color',[0 .7 .7],'LineWidth',2);  % for position

subplot(1,2,2);
title('Velocity')
xlabel('time(s)')
ylabel('Velocity')
h_v = animatedline('Color',[0 .5 .5],'LineWidth',2);  % for velocity
axis tight;
set(gca,'nextplot','replacechildren'); 

for k = 1:length(t)
    e = r - x_old;   % Error

    % Controller
    if (e>0)
        u = u_max;
    elseif (e<0)
        u = - u_max;
    else
        u = 0;
    end

    x_dot = (c/m)*u;    % Car Model
    x_new = x_old + dt*x_dot; %updating position 
    
    % Animate
    addpoints(h_x,t(k),x_old);    
    addpoints(h_v,t(k),x_dot);
    drawnow 
    frame = getframe(gcf);
    writeVideo(v,frame);
    pause(0.05)
    x_old = x_new;
end

% myVideo = VideoWriter('peaks.avi','Uncompressed AVI');
% open(myVideo);
% writeVideo(myVideo, frame);
% close(myVideo);
clc;
msg = ['error = ',num2str(e),' ,current location = ',num2str(x_new)];
disp(msg)
