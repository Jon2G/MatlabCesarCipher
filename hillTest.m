p=[0,1,2];
k=[2,1,3;11,21,16;1,2,3];
c=p*k;
disp(c);
ki=inv(k);
pe=c*ki;
disp(pe);