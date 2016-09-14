function C = metrocoef_f(G,N)
%Metropolis coefficients

C=zeros(N,N);
n=zeros(N,1);

for k=1:N
    n(k)=sum(G(k,:))+1;
end

for k=1:N
    for l=find(G(k,:))
        C(l,k)=1/max([n(k),n(l)]);
    end

    C(k,k)=1-sum(C(:,k));
    %C(k,k)=1/n(k);
end

end