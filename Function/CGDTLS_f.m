function v = CGDTLS_f(dl,L,x,d,h,mu,N,beta)
%centeralized gradient-descent TLS

%initialization
w=zeros(L,1);                             %initial estimates
v=zeros(dl,1);                            %mean-square deviation

for n=1:dl
    a=zeros(L,1);
    for k=1:N
        ep=(d(k,n)-x(:,k,n)'*w)/(w'*w+beta(k));
        a=a+ep*(x(:,k,n)+ep*w);
    end
    w=w+mu*a;
    
    v(n)=norm(h-w)^2;
end

end