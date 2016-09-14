function vi = DGDTLS_ATC_f(dl,L,x,d,h,mu,A,C,G,N,beta)
%diffusion gradient-descent TLS - adapt then combine

%initialization
w=zeros(L,N);                             %initial estimates
p=zeros(L,N);                             %initial itermediate estimates
vi=zeros(dl,N);                           %mean-square deviation

for n=1:dl
    for k=1:N
        p(:,k)=w(:,k);
        for l=[k,find(G(k,:))]
            ep=(d(l,n)-x(:,l,n)'*w(:,k))/(w(:,k)'*w(:,k)+beta(l));
            p(:,k)=p(:,k)+mu*C(l,k)*ep*(x(:,l,n)+ep*w(:,k));
        end
    end
    
    for k=1:N
        w(:,k)=zeros(L,1);
        for l=[k,find(G(k,:))]
            w(:,k)=w(:,k)+A(l,k)*p(:,l);
        end
    end
    
    for k=1:N
        vi(n,k)=norm(h-w(:,k))^2;
    end
end

end