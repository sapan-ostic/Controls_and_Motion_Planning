clear all;
close all;

%% Car Model
% x_dot = (c/m)*u;
% aim: x->r , e->0 as t->infinity

%% System Properties
c = 1
m = 1;     
g = 0.1;
%% state of system
x_old = 0;  %current state    
r = 70;     %desired state 
dt = 0.01;  %discrete time
t=0:dt:2;        %begin time
kp = 10;
ki = 1;
kd = 0.3;
E = 0;
%% Control Loop
e_old = r - x_old;

%Create animation handles
v = VideoWriter('PI_Regulator.avi');
open(v);
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
title('Position')
xlabel('time(s)')
ylabel('Position')

h_x = animatedline('Color',[0 .7 .7],'LineWidth',2);  % for position
h_g = animatedline('Color','b','LineWidth',2);  % for Goal

subplot(1,2,2);
title('Velocity')
xlabel('time(s)')
ylabel('Velocity')
h_v = animatedline('Color',[0 .5 .5],'LineWidth',2);  % for velocity
axis tight;
set(gca,'nextplot','replacechildren'); 

for k = 1:length(t)
    E = E+e_old;
    e_new = r - x_old;   % Error
    e_dot = e_new-e_old;
    % Controller
    u = kp*e_old + ki*E*dt + kd*e_dot/dt;
    
    x_dot = (c/m)*u - g*x_old;    % Car Model
    x_new = x_old + dt*x_dot; %updating position 
    
    % Animate
    addpoints(h_x,t(k),x_old);   
    addpoints(h_v,t(k),x_dot);
    addpoints(h_g,t(k),r);
    drawnow limitrate
   
    frame = getframe(gcf);
    writeVideo(v,frame);
  % pause(0.05)
    x_old = x_new;
    e_old = e_new;
end

% myVideo = VideoWriter('peaks.avi','Uncompressed AVI');
% open(myVideo);
% writeVideo(myVideo, frame);
% close(myVideo);
clc;
msg = ['error = ',num2str(e_old),' ,current location = ',num2str(x_new)];
disp(msg)
