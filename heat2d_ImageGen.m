% Heat Equation

clear
clc
%% Initial Set up
nx = 64;
ny = 64;
Lx = 1;
Ly = 1;
x = linspace(0, Lx, nx);
y = linspace(0, Ly, ny);
dx = x(2) - x(1);
dy = y(2) - y(1);

%% 2D temperature matrix and Boundary Conditions
T = 400*ones(nx, ny);
T(:,1) = 400;
T(1,:) = 900;
T(:,nx) = 800;
T(nx,:) = 600;
alpha = 1.4;
Told = T;

%% time loop
c = 0.5;
dt = (c*(dx^2))/(2*alpha);
t = 0:dt:0.5;
nt = length(t);

Tt=zeros(nx,ny,nt);
Tt(:,:,1) = T;

for k = 2:(nt-1)
    for j = 2:(nx-1)
        for i = 2:(ny-1)
            H = (((Told(i,j+1))-2*Told(i,j)+(Told(i,j-1)))/(dx^2));
            V = (((Told(i+1,j))-2*Told(i,j)+(Told(i-1,j)))/(dy^2));
            T(i,j) = Told(i,j) + alpha*dt*(H+V);
        end
    end
    Told = T;
    Tt(:,:,k) = T;
end

%% Plot results
figure(1)
contourf(x,y,T,'ShowText','on')
colorbar;
xlabel('Length')
ylabel('Width')

figure(2)
contourf(x,y,Tt(:,:,end-1),'ShowText','on')
colorbar;
xlabel('Length')
ylabel('Width')

%% write results to .txt
% dlmwrite('Heat.txt',Tt);

%% write to video
for i = 1:size(Tt,3)-1
    im = (Tt(:,:,i)/1000); %Normalizing Data between 0 and 1
    imshow(im)
    xlabel('Length')
    ylabel('Width')
    F(i) = getframe(gcf);
    filename = strcat('heatSim\heatSim',num2str(i),'.jpg');
    imwrite(im, filename)
end

video = VideoWriter(['heatSim.mp4'], 'MPEG-4');
video.FrameRate = 10;
open(video)
writeVideo(video, F); 
close(video)

