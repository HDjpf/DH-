%% This document is to calculate calibratio matrix
% 先运行一次这个代码，保存下A矩阵，其他代码运行excpet这个变量矩阵
clc;clear;
syms d1 d2 d3 d4 d5 d6 a1 a2 a3 a4 a5 a6 m1 m2 m3 m4 m5 m6
syms t1 t2 t3 t4 t5 t6 xx yy zz r p y x_offset
Test(1).parameter=[t1,d1,m1,a1];
Test(1).h=1;
Test(2).parameter=[t2,d2,m2,a2];
Test(2).h=1;
Test(3).parameter=[t3,d3,m3,a3];
Test(3).h=1;
Test(4).parameter=[t4,d4,m4,a4];
Test(4).h=1;
Test(5).parameter=[t5,d5,m5,a5];
Test(5).h=1;
Test(6).parameter=[t6,d6,m6,a6];
Test(6).h=1;

T_other=[eye(3,3) [x_offset;0;0];0 0 0 1];
choose=input('just base is 1, add measure is 0:');
T0_6_test=simplify(ran_romatrix(Test,1,6)); 
T=T0_6_test*T_other;

if choose      
    F=T(1:3,4);    % 不加测量坐标系转换
    A = [diff(F, m1), diff(F, a1), diff(F, d1), diff(F, t1), ...
         diff(F, m2), diff(F, a2), diff(F, d2), diff(F, t2), ...
         diff(F, m3), diff(F, a3), diff(F, d3), diff(F, t3), ...
         diff(F, m4), diff(F, a4), diff(F, d4), diff(F, t4), ...
         diff(F, m5), diff(F, a5), diff(F, d5), diff(F, t5), ...
         diff(F, m6), diff(F, a6), diff(F, d6), diff(F, t6),diff(F,x_offset)];
else
    test_rpy=[r,p,y];
    test_T33=RPY2R(test_rpy);
    test_xyz=[xx;yy;zz];
    Tca_0_test=[test_T33 test_xyz(1:3);0 0 0 1];
    T_test=Tca_0_test*T;    % 加测量坐标系转换
    F=T_test(1:3,4);
    A = [diff(F, xx), diff(F, yy), diff(F, zz), ...
         diff(F,  r), diff(F,  p), diff(F,  y), ...
         diff(F, m1), diff(F, a1), diff(F, d1), diff(F, t1), ...
         diff(F, m2), diff(F, a2), diff(F, d2), diff(F, t2), ...
         diff(F, m3), diff(F, a3), diff(F, d3), diff(F, t3), ...
         diff(F, m4), diff(F, a4), diff(F, d4), diff(F, t4), ...
         diff(F, m5), diff(F, a5), diff(F, d5), diff(F, t5), ...
         diff(F, m6), diff(F, a6), diff(F, d6), diff(F, t6), diff(F,x_offset)];
end
