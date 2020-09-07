x0 = 5;  
y0 = 5;  
z0 = 10; 

x_goal = 7; 


fid = fopen( 'numbers.txt', 'wt' );

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


for T1 = 0.1:0.1:1
    for T2 = 1:1:10
        for beta = 0.1:0.1:1.5
            for gamma = 0.1:0.1:1.5
                for sigma = 0.1:0.1:1.5
                      for i = 2:size

                          
                          
                                        
                                        f1 = z(i-1) * x(i-1) - beta  * x(i-1) * y(i-1);
                                        f2 = -gamma * y(i-1) + sigma * x(i-1) * y(i-1);
                                        psi_t = x(i-1) - x_goal;
                                        dfi = (- x_goal * f1) / (T2 * x(i-1) * x(i-1)) + beta * f2;

                                        fi = - (x(i-1) - x_goal) / (T2 * x(i-1)) + beta * y(i-1);
                                        
                                        psi_1 = z(i-1) - fi;
                                        
                                        U = - T1^(-1) * psi_1 + dfi;
                                       

                                       

                                        x(i) = x(i-1) + step * f1;
                                        y(i) = y(i-1) + step * f2;
                                        z(i) = z(i-1) + step * U;
                                        
                                        
                                        
                                        rest = size - size / 10;
                                        
                                        
                                        
                                        if(isnan(x(i)) || isnan(y(i))) 
                                            break
                                        elseif(i > rest && abs(psi_t)/x_goal > 0.01) 
                                            break
                                        elseif(x(i) > 100 || y(i) > 100) 
                                            break
                                        elseif(i==size)  
                                            fprintf( fid, '%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f\n', T1, T2, beta, gamma, sigma, x0, y0, z0, x_goal);

                                        end

                      end
                end
            end
        end
    end
end

fclose(fid); 