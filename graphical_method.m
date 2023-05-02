%graphical method
% maximize z=2x1+3x2 subject to the constraints:
%   x1 + 2x2 <= 200
%   x1 + x2 <= 1500
%   x2 <=600
%   x1 >= 0
%   x2 >= 0

clc;
close all;
a=[1 2;1 1;0 1;1 0;0 1];       
b=[200;1500;600;0;0];          
c=[2 3];                        
x1=0:0.1:max(b);                
x21=(b(1)-a(1,1)*x1)/a(1,2);   
x22=(b(2)-a(2,1)*x1)/a(2,2);   
x23=(b(3)-a(3,1)*x1)/a(3,2);    

x21=max(0,x21);
x22=max(0,x22); 
x23=max(0,x23); 
plot(x1,x21,'r',x1,x22,'g',x1,x23,'k');
legend('x1,x21','x1,x22','x1,x23');  
sol=[];

for i=1:length(a) 
    a1=a(i,:);
    b1=b(i);
    for j=i+1:length(a) 
        a2=a(j,:);
        b2=b(j);
        a3=[a1;a2];  
        b3=[b1;b2]; 
        x3=a3\b3;    
        sol=[sol,x3];  
    end
end 

sol

%removing values of x1,x2 from solutions which do not satisfy the constraints

x1=sol(1,:);                  %extracts first row of sol
x2=sol(2,:);                  %extracts second row of sol
y1=find(1*x1+2*x2>200);       %check which pair of x1,x2 do not satisfy the constraint
sol(:,y1)=[];                 %remove those pairs

x1=sol(1,:);
x2=sol(2,:);
y2=find(1*x1+1*x2>1500);
sol(:,y2)=[];

x1=sol(1,:);
x2=sol(2,:);
y3=find(x2>600);
sol(:,y3)=[];

x1=sol(1,:);
x2=sol(2,:);
y4=find(x1<0);
sol(:,y4)=[];

x1=sol(1,:);
x2=sol(2,:);
y5=find(x2<0);
sol(:,y5)=[];

x1=sol(1,:);
x2=sol(2,:);
sol
x1
x2

sol=sol';  
for i=1:length(sol)
    obj(i,:)=sum(sol(i,:).*c);  
end
 
[p,loc]=max(obj);
fprintf('the optimal value is %f\n',p);
fprintf('the optimal solution is');
disp(sol(loc,:));