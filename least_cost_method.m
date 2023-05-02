%least_cost_method
clc;
close all;
cost=[2 7 4;3 3 1;5 5 4;1 6 2];
a=[5 8 7 14]; 
b=[7 9 18]; 
if sum(a)==sum(b)
    fprintf('Balanced\n');
else
    fprintf('Unbalanced');
    if sum(a)<sum(b)
        cost(end+1,:)=zeros(1,size(a,2));
    elseif sum(b)<sum(a)
        cost(:,end+1)=zeros(1,size(a,1));
    end
end
icost=cost;
x=zeros(size(cost));
[m,n]=size(cost);
bfs=m+n-1;
for i=1:size(cost,1)                             %traverse row
    for j=1:size(cost,2)                         %traverse column
        hh=min(cost(:));                         %find min cost
        [row_index,col_index]=find(hh==cost);
        x11=min(a(row_index),b(col_index));
        [val,ind]=max(x11); 
        ii=row_index(ind);
        jj=col_index(ind); 
        y11=min(a(ii),b(jj)); 
        x(ii,jj)=y11;
        a(ii)=a(ii)-y11; 
        b(jj)=b(jj)-y11; 
        cost(ii,jj)=inf; 
    end
end
fprintf('Initial BFS= \n');
ib=array2table(x);
disp(ib);
totalbfs=length(nonzeros(x));
if totalbfs==bfs
    fprintf('Non Degenerate BFS \n');
else
    fprintf('Degenerate BFS \n');
end
initialcost=sum(sum(icost.*x));
fprintf('Cost= %d\n',initialcost);