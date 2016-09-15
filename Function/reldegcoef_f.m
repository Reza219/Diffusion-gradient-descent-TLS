function C = reldegcoef_f(G,N)
%relative-degree coefficients

C=zeros(N,N);
n=zeros(N,1);
s=zeros(N,1);

for k=1:N
    n(k)=sum(G(k,:))+1;
end

for k=1:N
    s(k)=n(k);
    for l=find(G(k,:))
        s(k)=s(k)+n(l);
    end
end

for k=1:N
    for l=[k,find(G(k,:))]
        C(l,k)=n(l)/s(k);
    end
    
    %C(k,k)=1-sum(C(:,k));
    %C(k,k)=n(k)/s(k);
end

end