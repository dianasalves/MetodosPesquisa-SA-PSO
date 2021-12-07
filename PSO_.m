%------------------------------
%Particle Swarm Optimization
%Ana Ferreira - al69136
%Diana Alves - al68557
%2020/2021
%------------------------------

close all
clear all
clc

%Função:
quality = @(x,y) -20*exp(-0.2*sqrt(1/2*(x.^2 + y.^2)))-exp(1/2*(cos(2*pi*x)+cos(2*pi*y))) + 20 + exp(1);

dim = 32.768;

%Inicialização aleatorio no espaço:
x1 = linspace(-32.768,32.768,100); %x1 tem os valores compreendidos entre -32.768 e 32.768 em 100 iterações   
x2 = linspace(-32.768,32.768,100); %x2 tem os valores compreendidos entre -32.768 e 32.768 em 100 iterações
[X1,X2] = meshgrid(x1,x2);
FX = quality(X1,X2);

contour(X1,X2,FX,20);

hold on %Segurar o gráfico

%Inicialização das variáveis:
t=1;
%Numero de iteraçoes:
n_iter=2000;
%Posição inicial:
x=(2*rand(5,2)-1)*32.768;
%Melhor posição:
b=x;
%FitB
Fitb= quality(b(:,1), b(:,2));
%FitX
Fitx= quality(x(:,1), x(:,2));
%G
[Fitg,ig]=min(Fitb);
g=b(ig,:);
%Fator de Inercia:
w=linspace(0.7,0.4, n_iter);
%Velocidade Inicial:
v=(2*rand(5,2)-1);


%Armazenar Valores  
bestX=zeros(n_iter,2);
bestF=Fitg;

 
%while(!(criterio de paragem)):
while(t < n_iter)
    %t=t+1:
    t=t+1
    %constante cognitiva:
    c1=rand(5,2);
    %constante social:
    c2=rand(5,2);
    %atualizar a velocidade das particulas:
    v= w(t)*v+ 2* c1.*(b-x) + 2* c2.*(ones(5,1)*g - x);
    %atulizar posição das particulas:
    x=x+v;
    
    %Mostra no grafico
    x=min(max(x,-dim),dim);
    
    Fitx= quality(x(:,1), x(:,2));
    
    %Gráfico em 2D
    figure(1) 
    plot(x(1,1), x(1,2), 'bo')
    plot(x(2,1), x(2,2), 'mo')
    plot(x(3,1), x(3,2), 'co')
    plot(x(4,1), x(4,2), 'ko')
    plot(x(5,1), x(5,2), 'go')
    plot(g(1),g(2),'ro')
    
    %Gráfico em 3D
    figure(2)
    surfc(X1,X2,FX)
    hold on
    shading interp
    plot3(x(1,1), x(1,2),Fitx, 'bo')
    plot3(x(2,1), x(2,2),Fitx, 'mo')
    plot3(x(3,1), x(3,2),Fitx, 'co')
    plot3(x(4,1), x(4,2),Fitx, 'ko')
    plot3(x(5,1), x(5,2),Fitx, 'go')
    plot3(g(1),g(2),Fitx,'ro')  
    
    
    for i=1:5
        %
        if Fitb(i) > Fitx(i)
        %atualizar o b
        b(i,:)= x(i,:);
        Fitb(i,:)= Fitx(i,:);   
      
        end 
    end
    %atualizar o g
    [Fitg,ig]=min(Fitb);
    g=b(ig,:);
    
    %Atualizar o vetor de armazenamento de vetores
    
    bestX(t,1)=g(1);
    bestX(t,2)=g(2);
    bestF(t)=Fitg;  
end

hold off

iter=1:1:n_iter; 

%Gráfico para o melhor F
figure(3)
semilogx(iter, bestF,'c' ,'linewidth', 2);
title('Gráfico da Função')
xlabel('Número de Iterações')
ylabel('Melhor F')
yline(0,'--k')%minimo global
hold off

%Gráfico para o melhor X e Y
figure(4)
subplot(2,1,1)
plot(iter, bestX(:,1), 'y-', 'linewidth', 2);
hold on
plot(iter, bestX(:,2), 'g-', 'linewidth', 2);
axis([1 n_iter -32.768 32.768]);
hold off
title('Gráfico das Posições');
yline(0,'--k');%minimo global
legend('x(1)', 'x(2)', 'Minimo Global');
xlabel('Número de Iterações');
ylabel('Melhores Valores de x e y');
hold off


