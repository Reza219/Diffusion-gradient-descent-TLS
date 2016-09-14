function v = BCCLMS_f(dl,L,x,d,h,mu,N,npi)
%centeralized bias-compensated LMS

%initialization
w=zeros(L,N);                             %initial estimates
v=zeros(dl,1);                            %mean-square deviation

for n=1:dl
    a=zeros(L,1);
    for k=1:N
        a=a+x(:,k,n)*(d(k,n)-x(:,k,n)'*w)+npi(k)*w;
    end
    w=w+mu*a;
    
    v(n)=norm(h-w)^2;
end

end