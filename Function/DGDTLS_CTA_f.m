function vi = DGDTLS_CTA_f(dl,L,x,d,h,mu,A,C,G,N,beta)
%diffusion gradient-descent TLS - combine then adapt 

%initialization
w=zeros(L,N);                             %initial estimates
p=zeros(L,N);                             %initial itermediate estimates
vi=zeros(dl,N);                           %mean-square deviation

for n=1:dl
    for k=1:N
        p(:,k)=zeros(L,1);
        for l=[k,find(G(k,:))]
            p(:,k)=p(:,k)+C(l,k)*w(:,l);
        end
    end
    
    for k=1:N
        w(:,k)=p(:,k);
        for l=[k,find(G(k,:))]
            ep=(d(l,n)-x(:,l,n)'*p(:,k))/(p(:,k)'*p(:,k)+beta(l));
            w(:,k)=w(:,k)+mu*A(l,k)*ep*(x(:,l,n)+ep*p(:,k));
        end
    end
    
    for k=1:N
        vi(n,k)=norm(h-w(:,k))^2;
    end
end

end