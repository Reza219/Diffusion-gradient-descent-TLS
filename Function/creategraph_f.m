%Creates a connection matrix for a random graph

%INPUTS:
%type --> Number from 1 to 5, selecting the type of graph
%         1=fully connected, 2=line topology, 3=tree topology,
%         4=random starting from tree, 5=random starting from chain
%nn   --> Number of nodes in the graph
%lpn  --> Average number of links per node (only for type=4 or 5)

%OUTPUTS:
%G --> Connection matrix

%Example input
%G=creategraph(4,20,3)

function G=creategraph_f(type,nn,lpn)

if type==1 %fully connected graph
    G=ones(nn,nn);
    
elseif type==2 %line topology graph
    G=zeros(nn,nn);
    for k=1:nn
        if k~=nn
            G(k,k+1)=1;
        end
        if k~=1
            G(k,k-1)=1;
        end
    end
    
elseif type==3 %generate random tree
    G=zeros(nn,nn);
    for k=2:nn
        q=floor((k-1)*rand(1))+1;
        G(k,q)=1;
        G(q,k)=1;
    end
    
elseif type==4 %random connected graph
    %first, generate random tree
    G=zeros(nn,nn);
    for k=2:nn
        q=floor((k-1)*rand(1))+1;
        G(k,q)=1;
        G(q,k)=1;
    end
    while mean(sum(G))<lpn
        %take random node and connect to another random node
        k=floor(nn*rand(1))+1;
        q=floor(nn*rand(1))+1;
        while G(k,q)==1 || k==q  %no existing link and no self loop
            k=floor(nn*rand(1))+1;
            q=floor(nn*rand(1))+1;
        end
        G(k,q)=1;
        G(q,k)=1;
    end
    
elseif type==5 %random connected graph, starting from chain
    %first, generate a chain
    G=zeros(nn,nn);
    G(1,2)=1;
    G(end,end-1)=1;
    for k=2:nn-1
        
        G(k,k-1)=1;
        %G(k,k)=1;
        G(k,k+1)=1;
    end
    while mean(sum(G))<lpn-2/nn
        %take random node and connect to another random node
        k=floor(nn*rand(1))+1;
        q=floor(nn*rand(1))+1;
        while G(k,q)==1 || k==q  %no existing link and no self loop
            k=floor(nn*rand(1))+1;
            q=floor(nn*rand(1))+1;
        end
        G(k,q)=1;
        G(q,k)=1;
    end
    
end