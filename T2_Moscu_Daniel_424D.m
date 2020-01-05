%Moscu Daniel
%424 D
%Numarul de ordine 17
%Semnal dreptunghiular cu perioada P=40[sec]
%Durata semnalelor D=17[sec]
%Numar de coeficienti Fourier N=50

P=40; 
D=17; 
N=50; 
f=1/P; 
w0=2*pi*f; %pulsatia
rez=0.1; %rezolutia temporala a semnalului

s1=[ones(1,D/rez),zeros(1,(P-D)/rez)]; %o perioada din semnalul dreptunghiular
t=0:rez:P; %timpul echivalent petru o perioada
perioada=P/rez;%nr de  esantioane dintr-o perioada

semnal=repmat(s1,1,5);%repetam semnalul initial de 5 ori
figure
plot(semnal)
title('5 perioade din semnal')
xlabel('t[s]')
ylabel('A')


%Determinam coeficientii Seriei Fourier Exponentiale
xk=zeros(1,2*N+1);
for m=-N:1:N
    for l=1:1:perioada
    xk(m+N+1)= xk(m+N+1)+semnal(l)*exp(-1i*m*w0*t(l));
    end
end
figure
stem((-N:N),abs(xk)) %spectrul semnalului
title('Spectrul  de amplitudini al semnalului x(t)') 
s_rec=zeros(1,perioada); %initializam semnalul pe care il vom reconstrui
for l=1:1:perioada
    for m=-N:1:N
        s_rec(l)= s_rec(l)+xk(m+N+1)*exp(1i*m*w0*t(l));
    end
end
s_rec=s_rec/perioada;%normam semnalul reconstruit
figure
plot(real(s_rec))
hold on
plot(s1,'color','r')
title('x(t)-verde, Reconstructia folosind N coeficienti - albastru')


%Seriile Fourier( SFC, SFT, SFA) practic aproximeaza
%semnalul periodic printr-o suma infinita de sinusuri sau cosinusuri
%fiecare putand avea diferite frecvente si fiecare avand un coef propriu

%Deoarece numarul de termeni este finit, nu putem spune ca semnalul initial
%este aproximat perfect. Cu cat acest numar este marit, cu atat creste si
%calitatea aproximarii, adica scade marja de eroare. 