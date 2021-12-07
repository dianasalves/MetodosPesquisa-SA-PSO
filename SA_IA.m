%------------------------------
%Simulated Annealing
%Ana Ferreira - al69136
%Diana Alves - al68557
%2020/2021
%------------------------------

close all
clear all
clc

%Inicializa��o das Vari�veis:
%numero de itera��es
n_iter=2000;
%vari�vel usada no ciclo while
t=1; 
%temperatura m�xima
Tmax=5;
%temperatura inicial � igual � temperatura maxima
T=Tmax;
%Valor do alpha utilizado para calcular a nova temperatura
alfa=0.94;
%Numero maximo de iteracoes do primeiro ciclo
T_iteracao=5; 
%Energia
E=0;

%Fun��o
quality = @(x,y) -20*exp(-0.2*sqrt(1/2*(x.^2 + y.^2)))-exp(1/2*(cos(2*pi*x)+cos(2*pi*y))) + 20 + exp(1);

dim = 32.768;

x1 = linspace(-32.768,32.768,100); %x1 tem os valores compreendidos entre -32.768 e 32.768 em 100 itera��es  
x2 = linspace(-32.768,32.768,100); %x2 tem os valores compreendidos entre -32.768 e 32.768 em 100 itera��es
[X1,X2] = meshgrid(x1,x2);
FX_all = quality(X1,X2);

contour(X1,X2,FX_all,20);

hold on %Segurar o gr�fico

%cria um x(1) e x(2)
x=32.768*(rand(1,2)*2-1);

%Gerar uma fun��o, a partir dos dois valores aleat�rios gerados
FX=quality(x(1,1), x(1,2)); 
% o vetor x tem as coordenadas x(1) e x(2)
plot(x(1),x(2),'b*')

%Inicio do preenchimento dos vetores com os valores encontrados
F_plot(1)=FX;
T_plot(1)=T;
%Inicio do preenchimento da matriz com os valores encontrados
x_all=zeros(n_iter, 2);

%while(!(criteriodeparagem)):
while(t<=n_iter)
    n=1;
    %while( n < = t_maximo_de_iteracoes):
    while(n<=T_iteracao)
        %inicializar x_new
        x_new= x + 1*(rand(1,2)*2-1); 
        x_new = min(max(x_new,-dim),dim); % nao deixa sair a solu��o do espa�o de pesquisa ESP
        
        %inicializar F_new
        F_new=quality(x_new(1,1), x_new(1,2)); 
    
        %Calcular o Delta
        E=F_new-FX;
    
        %Calcular o P
        p=1/(1+ exp(E/T));
        %Preenchimento do vetor das probabilidades
        p_plot(t)=p;
 
        %Se a difren�a for negativa ou 0 ou se o valor aleatorio for menor do
        %que P,x,y, e F alteram o valor.
        if(E<=0) %movimento de descida
            x = x_new;
            FX=F_new;
            plot(x(1),x(2),'bo')
        else
            if rand(1)<p %movimento de subida
            x = x_new;
            FX=F_new;
            plot(x(1),x(2),'bo')
        end
    end
     %Armazenamento do valores nos vetores
     F_plot(t)=FX;
     x_all(t,1)=x(1);
     x_all(t,2)=x(2);
     T_plot(t)=T;
    
     n=n+1;
    end
    %T = Tnew:
    T=alfa*T;
    %t=t+1
    t=t+1;
end   
 
%Fun��o
 figure(1)
 plot(x(1),x(2),'r*');
 title('-20*exp(-0.2*sqrt(1/2*(x.^2 + y.^2)))-exp(1/2*(cos(2*pi*x)+cos(2*pi*y))) + 20 + exp(1)');
 hold off

%Gr�fico Simulated Annealing em 3D
figure(2)
surfc(X1,X2,FX_all)
hold on
shading interp
plot3(x_all(:,1),x_all(:,2),F_plot,'or', 'linewidth', 2, 'markersize', 4);
%plot(x_plot,F_plot,'or', 'linewidth', 2, 'markersize', 4);
legend('FX','', 'X Alcan�ados');
hold off

iter=1:1:n_iter; 
F_ideal=0*ones(1, n_iter);
x_ideal=0*ones(1, n_iter);

figure(3)
subplot(2,1,1)
semilogx(iter, F_plot, 'c', 'linewidth', 2);
axis([1, n_iter, -32.768 32.768]);
hold on
plot(iter, F_ideal, 'k--', 'linewidth', 4);
legend('FX', 'Minimo Global');
xlabel('N�mero de Itera��es');
ylabel('Fun��o')
hold off
subplot(2,1,2)
semilogx(iter, x_all(:,1), 'y-', 'linewidth', 2);
hold on
semilogx(iter, x_all(:,2), 'g-', 'linewidth', 2);
plot(iter, x_ideal, 'k--', 'linewidth', 4);
axis([1 n_iter -32.768 32.768]);
hold off
legend('x(1)', 'x(2)', 'Minimo Global');
xlabel('N�mero de Itera��es');
ylabel('Valores de x')
hold off

%Gr�fico da Probabilidade e da Temperatura
figure(4)
subplot(2,1,1)
semilogx(iter, p_plot, '.', 'linewidth', 1);
axis([1 n_iter -1 10]);
xlabel('N�mero de Itera��es');
ylabel('Probabilidade');
hold on
subplot(2,1,2)
semilogx(iter, T_plot, 'b', 'linewidth', 2);
xlabel('N�mero de Itera��es');
ylabel('Temperatura');
hold off
