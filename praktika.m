function praktika(T1, T2, beta, gamma, sigma, x0, y0, z0, x_goal)  

left = 1;
right = 100;
step = 0.01;
mass = left:step:right;
size = length(mass);
x = zeros(1,size);
y = zeros(1,size);
z = zeros(1,size);



x(1) = x0; 
y(1) = y0;  
z(1) = z0;  








for i = 2:size
    
    f1 = z(i-1) * x(i-1) - beta  * x(i-1) * y(i-1);
                                        f2 = -gamma * y(i-1) + sigma * x(i-1) * y(i-1);

                                        dfi = (- x_goal * f1) / (T2 * x(i-1) * x(i-1)) + beta * f2;

                                        fi = - (x(i-1) - x_goal) / (T2 * x(i-1)) + beta * y(i-1);
                                        
                                        psi_1 = z(i-1) - fi;
                                        
                                        U = - T1^(-1) * psi_1 + dfi;
                                       


                                        x(i) = x(i-1) + step * f1;
                                        y(i) = y(i-1) + step * f2;
                                        z(i) = z(i-1) + step * U; %каждый след х использует предыдущий 
    
    
end



mass_plot = 1:size;
hold on;
plot(mass_plot, x, 'b', mass_plot, y, 'r', mass_plot, z, 'g');
legend('Prey', 'Predator ', 'Food');
title('Predator-Prey with Food');
ylabel('X,Y,Z');
grid on;
hold off;
end
