% Wave Equation

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
c = 0.5;
p = 2;
q = 1;
alpha = 1.4;
sigma = 1/sqrt(2);
gamma = 1/sqrt(2);
dt = sigma*(dx/c);
t = 0:dt:1;
nt = length(t);

%% 2D temperature matrix and Boundary Conditions
u = zeros(length(x),length(y),length(t));
u(:,:,1) = transpose(sin(p.*pi.*x))*sin(q.*pi.*y);

%% time loop

for n=2:length(t)-1
    for i=2:length(x)-1
        for j=2:length(y)-1
            u(i,j,n+1)= (sigma^2)*(u(i+1,j,n)-2*u(i,j,n)+u(i-1,j,n))...
                +(gamma^2)*(u(i,j+1,n)-2*u(i,j,n)+u(i,j-1,n)) + 2*u(i,j,n) - u(i,j,n-1);
        end
    end
end

%% Plot results
figure(1)
contourf(x,y,u(:,:,end-1),'ShowText','on')
colorbar;
xlabel('Length')
ylabel('Width')



%% write results to .txt
dlmwrite('Wave.txt',u);