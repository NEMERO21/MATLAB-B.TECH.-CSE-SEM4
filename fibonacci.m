clc;
close all;
%define objective function
f=@(x)(x*(x-2));
lower_limit=0;
upper_limit=1.5;
n=4; %iterations

%fibonacci
fib=ones(1,n);%as initial values are 1 so initialize sequence to 1
for i=3:n+1 %indexing starts from 1 so loop from 3
    fib(i)=fib(i-1)+fib(i-2);
end

%search method adn constructing table
for k=n+1:-1:3 %till number of iterations
    l0=upper_limit-lower_limit;
    ratio1=(fib(k-2)/fib(k));%computing ratio according to formula
    ratio2=(fib(k-1)/fib(k));%computing ratio according to formula
    %x1 and x2 for table according to formula
    x2=lower_limit+ratio2*(l0);
    x1=lower_limit+ratio1*(l0);
    fx1=f(x1);
    fx2=f(x2);
    if fx1<fx2 %find minimum
        upper_limit=x2; %update upper_limit
    elseif fx1>fx2
        lower_limit=x1; %update lower_limit
    end
end

%print table
variables={'L','R','x1','x2','fx1','fx2'};
rsl(k,:)=[lower_limit upper_limit x1 x2 fx1 fx2];
result=array2table(rsl);
result.Properties.VariableNames(1:size(result,2))=variables;
disp(result);

%optimal result
xopt=(lower_limit+upper_limit)/2;
fopt=f(xopt);
fprintf('Optimal value of x = %f \n',xopt);
fprintf('Optimal value of f(x) = %f \n',fopt);