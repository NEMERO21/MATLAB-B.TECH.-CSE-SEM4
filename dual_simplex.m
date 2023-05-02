%dual_simplex
clc;
close all;
Z=[2 0 1];                                           %Enter cost
A=[-1 -1 1;-1 2 -4];                                 %Enter coefficient matrix
[m n] = size(A);
b=[-5;-8];                                           %Enter rhs column vector
variables=["x1","x2","x3","s1","s2","Sol"];
s=eye(size(A,1));
Z=[Z zeros(1,size(b,1)) 0];
A=[A s b]; 



BV = n+1:1:n+m;

%alternative of above line for finding starting bfs
%for j=1:size(s,2)
%    for i=1:size(A,2)
%        if A(:,i)==s(:,j) %checking identity matrix
%            BV=[BV i]; %preserving location of identity
%        end
%    end
%end


fprintf("Basic Variables:\n");
disp(variables(BV));
run=true;

%dual simplex start
while run
    %compute zjcj value of table
    ZjCj=Z(BV)*A-Z

    table=[ZjCj;A];
    %print the table
    simplexTable=array2table(table);
    simplexTable.Properties.VariableNames(1:size(simplexTable,2))=variables;
    disp(simplexTable);

    if any(A(:,end)<0)                   %any value in sol column is negative
        fprintf("Infeasible BFS.\n");

         %finding leaving variable
        [leavingVal,pivotRow]=min(A(:,end));
        fprintf("Leaving Row=%d \n",pivotRow);

         %find entering variable
        Row=A(pivotRow,1:end-1);
        Zrow=ZjCj(:,1:end-1);
        for i=1:size(Row,2)
            if Row(i)<0
                ratio(i)=abs(Zrow(i)./Row(i)); %finding ratio of zjcj and leaving row
            else
                ratio(i)=inf;
            end
        end

        [minRatio,pivotCol]=min(ratio); %finding minimum ratio
        BV(pivotRow)=pivotCol; %finding pivot column and update basic variable
        fprintf("New Basic Variables:\n");
        disp(variables(BV));
        
        pivotVal=A(pivotRow,pivotCol); %finding pivot cell
        A(pivotRow,:)=A(pivotRow,:)./pivotVal;
        %performing row operations to get next iteration
        for i=1:size(A,1)
            if i~=pivotRow
                A(i,:)=A(i,:)-A(i,pivotCol).*A(pivotRow,:);
            end
            ZjCj=ZjCj-ZjCj(pivotCol).*A(pivotRow,:);
        end
    else
        run=false;
        fprintf("Feasible BFS.\n");
    end
end