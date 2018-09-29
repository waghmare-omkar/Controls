%% Generating Scrolling Road Profile in Matlab
clc
clear
x = linspace(1,200,2000);
y = -3*ones(length(x),1);
z = [x;y']';

figure(1); hold all;
set(gca,'Color','[.1 0.1 0.1]')
for i = 1:1:length(x)
    plot(x',y,'k--'); 
    rectangle('Position',[x(i)-1,y(i),x(i+20),2],'FaceColor',[.5 .5 .5],'EdgeColor','white','LineWidth',4)
    rectangle('Position',[x(i)-1,y(i)+1,x(i+20),0.05],'FaceColor','yellow','EdgeColor','none','LineWidth',1)
    rectangle('Position',[x(i)-1,y(i)+0.9,x(i+20),0.05],'FaceColor','yellow','EdgeColor','none','LineWidth',1)
    axis([x(i) x(i+20) -5 5]);
    drawnow
end