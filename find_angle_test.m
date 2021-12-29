%% Daclartion
clc;clearvars -except A F;
% load pointset.mat;
J=importdata('Evo7J-121.txt');
TR4J=deg2rad(J);
C=importdata('Evo7C-121.txt');
TR4C=0.001*C;
% 给DH表中的参数赋名义值（DH原表格数值）
d1_id=0.368;d2_id=0.0  ;d3_id=0.0  ;d4_id=0.2795;d5_id=0.0 ;d6_id=0.0925;
a1_id=0.0  ;a2_id=0.020;a3_id=0.265;a4_id=0.020 ;a5_id=0.0 ;a6_id=0.0  ;
m1_id=0.0  ;m2_id=-pi/2;m3_id=0.0  ;m4_id=-pi/2 ;m5_id=pi/2;m6_id=-pi/2;
xx_id=1.91754917693416 ; yy_id=-0.669077458592982 ; zz_id=-0.256351601613697;
r_id=3.13642179020714  ; p_id=3.13774022235397    ; y_id=-0.266694682416654 ;
x_offset_id=0.01;
d1=0.350;d2=0.0  ;d3=0.0  ;d4=0.340;d5=0.0 ;d6=0.080;
a1=0.0  ;a2=0.040;a3=0.340;a4=0.045 ;a5=0.0 ;a6=0.0  ;
m1=0.0  ;m2=-pi/2;m3=0.0  ;m4=-pi/2 ;m5=pi/2;m6=-pi/2;
xx=0.695450 ; yy=2.429244 ; zz=-0.645561;
r=0.020096  ; p=0.006158  ; y=-2.682874 ;
x_offset=0.01;
%% 预给定机器人各项参数误差
delta_x=zeros(31,1);
total_error=zeros(31,1);
go=1;
% Bb=1;
%% 迭代十次，自定义十组数值
j=1;
while (norm(delta_x)>1e-10)||go
% for time=1:2
    disp(j)
        
    Aa=zeros(168,31);
    Bb=zeros(168,1);
    if j==1
        for i=1:56
        TR4J(i,1) = TR4J(i,1)+delta_x(10);
        TR4J(i,2) = TR4J(i,2)+delta_x(14)-pi/2;
        TR4J(i,3) = TR4J(i,3)+delta_x(18);
        TR4J(i,4) = TR4J(i,4)+delta_x(22);
        TR4J(i,5) = TR4J(i,5)+delta_x(26);
        TR4J(i,6) = TR4J(i,6)+delta_x(30);
        t1=TR4J(i,1);t2=TR4J(i,2);t3=TR4J(i,3);
        t6=TR4J(i,6);t4=TR4J(i,4);t5=TR4J(i,5);
        f = double(subs(F));
        b = TR4C(i,:)'-f;
        Bb((i-1)*3+1:(i-1)*3+3,1)=b;
        a = double(subs(A));
        Aa((i-1)*3+1:(i-1)*3+3,:)=a;
        end
    else
    for i=1:56
        TR4J(i,1) = TR4J(i,1)+delta_x(10);
        TR4J(i,2) = TR4J(i,2)+delta_x(14);
        TR4J(i,3) = TR4J(i,3)+delta_x(18);
        TR4J(i,4) = TR4J(i,4)+delta_x(22);
        TR4J(i,5) = TR4J(i,5)+delta_x(26);
        TR4J(i,6) = TR4J(i,6)+delta_x(30);
        t1=TR4J(i,1);t2=TR4J(i,2);t3=TR4J(i,3);
        t6=TR4J(i,6);t4=TR4J(i,4);t5=TR4J(i,5);
        f = double(subs(F));
        b = TR4C(i,:)'-f;
        Bb((i-1)*3+1:(i-1)*3+3,1)=b;
        a = double(subs(A));
        Aa((i-1)*3+1:(i-1)*3+3,:)=a;
    end
    end
    err=reshape(Bb,3,length(Bb)/3)';
    delete=[7,8,9,10,11,13,15,17,19,23,24,25,27,28];
    
    w=tanh(Bb)./Bb;
    W=diag(w);

    Aa(:,delete) = [];
    rrr=rank(Aa)
    c=cond(Aa)
    temp=zeros(17,1);
%     temp = pinv(Aa'*Aa)*Aa'*Bb
    temp = pinv(Aa'*W*Aa)*Aa'*W*Bb
%     temp = Aa\Bb;
    re=0;
    delta_x=zeros(31,1);
    for x=1:31
        if ismember(x,delete)
            delta_x(x)=0;
            re=re+1;
        else
            delta_x(x)=temp(x-re);
        end
    end
    delta_x
        % 参数误差补偿
    d1=d1+delta_x(9);
    m1=m1+delta_x(7);
    a1=a1+delta_x(8);
    
    d2=d2+delta_x(13);
    m2=m2+delta_x(11);
    a2=a2+delta_x(12);
    
    d3=d3+delta_x(17);
    m3=m3+delta_x(15);
    a3=a3+delta_x(16);
    
    d4=d4+delta_x(21);
    m4=m4+delta_x(19);
    a4=a4+delta_x(20);
    
    d5=d5+delta_x(25);
    m5=m5+delta_x(23);
    a5=a5+delta_x(24);

    d6=d6+delta_x(29);
    m6=m6+delta_x(27);
    a6=a6+delta_x(28);
    
    xx=xx+delta_x(1);
    yy=yy+delta_x(2);
    zz=zz+delta_x(3);
    r =r+delta_x(4);
    p =p+delta_x(5);
    y =y+delta_x(6);
    
    x_offset=x_offset+delta_x(31);
    norm(delta_x)
    j=j+1;
    go=0;

    total_error=total_error+delta_x;
end
err=reshape(Bb,3,length(Bb)/3)';
save('ols_error.txt','err');