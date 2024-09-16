/*
Taking the beam spot size at a distance of z from the beam waist, W(z)=5mm, 
make a computer program to obtain the laser beam pattern (in x-y Plane) 
for transverse modes TEMoo, TEMo1, TEM1o, TEM11, TEM2o, TEM02, TEM22, TEM21, and TEM12 . 
Also obtain the pattern when all these transvers modes appear simultaneously in this laser 
(for simplicity, take the peak intensity for each mode same). 
Finally, from this overlapped pattern, plot the intensity distribution along two mutually perpendicular diameters 
and comment on this observation.
*/


xrange=linspace(-10,10,501);
yrange=linspace(-10,10,501);

[X,Y]=meshgrid(xrange,yrange);
Uc=zeros(size(X));
Uk=zeros(size(X));
k=0;

for i=0:1:2
    for j=0:1:2
        k=k+1;
        Uc=zeros(size(X));
        Uc=TEM(i,j,X,Y);
        Uk=Uk+Uc;
        subplot(3,3,k)
        surf(X,Y,Uc);
    end
end
figure;
surf(X,Y,Uk)
figure;
Uk=Uk.*Uk;
plot(xrange,Uk(251,:))
figure;
plot(yrange,transpose(Uk(:,251)));

function ot=TEM(p,q,X,Y)
    ot=zeros(size(X));
    pt = H(p,(0.2*X*sqrt(2)));
    qt=H(q,(0.2*Y*sqrt(2)));
    et=exp((-0.04)*(X.*X+Y.*Y));
    ot=pt.*qt.*et;
end

function otpm=H(p,X)
    otpm=zeros(size(X));
    if(p==0)
        otpm=1;
    elseif(p==1)
        otpm=2*X;
    else
        otpm=4*X.*X-2;
    end
end



