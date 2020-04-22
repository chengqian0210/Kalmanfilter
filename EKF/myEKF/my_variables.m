%parameters define
simT = 0.1;%define simulation step
load('E:\Project\¿¨¶ûÂüÂË²¨\EKF\myEKF\Measure.mat');%load measured data
load('E:\Project\¿¨¶ûÂüÂË²¨\EKF\myEKF\Real.mat');%load real data
measuredValue = TimeRPhi;
realValue = TXYdXdYAxAyTPhi;

%distribute measured data
measured_T = measuredValue(1,:);
measured_R = measuredValue(2,:);
measured_Phi = measuredValue(3,:);

%distribute real data
real_T = realValue(1,:);
real_X = realValue(2,:);
real_Y = realValue(3,:);
real_Vx = realValue(4,:);
real_Vy = realValue(5,:);
real_Ax = realValue(6,:);
real_Ay = realValue(7,:);
real_R = realValue(8,:);
real_Phi = realValue(9,:);

%State Variables-----------------------------------%
trX = zeros(6, 1);
trX(1) = 1e4;
%---------------------------------------------------%

%define the trace system
lt=0.3;
Field1 = 'A';
sA = [zeros(4, 2), eye(4); zeros(2, 4), (-1) * lt * eye(2)]; %·Ö¿é¸³Öµ
A = eye(6)+simT*sA;
Field2 = 'Qk';
mQk = simT * diag([1e4 * ones(1, 2), 1e4 *  ones(1, 2), 1e4, 1e-1]);
Field3 = 'h';
vHx = zeros(2, 1);
Field4 = 'H';
mHk = zeros(2, 6);
Field5 = 'Rk';
mRk = diag([1e-1 , 1e-1]);

global traceSys;
traceSys = struct(Field1, A, Field2, mQk, ...
     Field3, vHx, Field4, mHk, ...
    Field5, mRk);
%--------------------------------------------------%

%Parameters of EKF-------------------------------%
ekfPk = 1e6 * eye(6);
%--------------------------------------------------%

