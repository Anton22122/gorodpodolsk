x0 = 5;  %ОБЮБМШОПЕ ЪОБЮЕОЙЕ ЦЕТФЧ
y0 = 5;  %ОБЮБМШОПЕ ЪОБЮЕОЙЕ ИЙЭОЙЛПЧ
z0 = 10; %ОБЮБМШОПЕ ЪОБЮЕОЙЕ РЙФБОЙС ДМС ЦЕТФЧ

x_goal = 7; %ГЕМЕЧПЕ ЪОБЮЕОЙЕ ЦЕТФЧ


fid = fopen( 'numbers.txt', 'wt' );%открытие файла для записи 

left = 1; %левая граница интервала
right = 100; %правая граница интервала
step = 0.01; %шаг 
mass = left:step:right;
size = length(mass);

x = zeros(1,size); %матрица значений x
y = zeros(1,size); %матрица значений y
z = zeros(1,size); %матрица значений z

x(1) = x0;
y(1) = y0;
z(1) = z0;

%УЙУФЕНБ ГЙЛМПЧ ДМС РПДВПТБ РПДИПДСЭЙИ ЛПЬЖЖЙГЙЕОФПЧ
for T1 = 0.1:0.1:1
    for T2 = 1:1:10
        for beta = 0.1:0.1:1.5
            for gamma = 0.1:0.1:1.5
                for sigma = 0.1:0.1:1.5
                      for i = 2:size

                          
                          
                                        %Окончательная система уравнений 
                                        f1 = z(i-1) * x(i-1) - beta  * x(i-1) * y(i-1);
                                        f2 = -gamma * y(i-1) + sigma * x(i-1) * y(i-1);
                                        psi_t = x(i-1) - x_goal;
                                        dfi = (- x_goal * f1) / (T2 * x(i-1) * x(i-1)) + beta * f2;

                                        fi = - (x(i-1) - x_goal) / (T2 * x(i-1)) + beta * y(i-1);
                                        
                                        psi_1 = z(i-1) - fi;
                                        
                                        U = - T1^(-1) * psi_1 + dfi;
                                       

                                        %вычесление очередного  x, y, z

                                        x(i) = x(i-1) + step * f1;
                                        y(i) = y(i-1) + step * f2;
                                        z(i) = z(i-1) + step * U;
                                        
                                        
                                        
                                        rest = size - size / 10; %Посление 10% значений
                                        
                                        %Условия проверки коэфицентов
                                        
                                        if(isnan(x(i)) || isnan(y(i))) %Проверка на бесконечность 
                                            break
                                        elseif(i > rest && abs(psi_t)/x_goal > 0.01) %Проверка на приближение к цели  последних 10% значений
                                            break
                                        elseif(x(i) > 100 || y(i) > 100) %проверки на большие числа
                                            break
                                        elseif(i==size) %при успешной проверке всех значений программа записывает их в текстовый документ 
                                            fprintf( fid, '%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f\n', T1, T2, beta, gamma, sigma, x0, y0, z0, x_goal);

                                        end

                      end
                end
            end
        end
    end
end

fclose(fid); %ЪБЛТЩФЙЕ ЖБКМБ