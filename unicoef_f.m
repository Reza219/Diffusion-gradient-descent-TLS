function C = unicoef_f(G,N)
%uniform coefficients

C=zeros(N,N);

for k=1:N
    for l=find(G(k,:))
        C(l,k)=1/(sum(G(k,:))+1);
    end

    C(k,k)=1-sum(C(:,k));
end

end