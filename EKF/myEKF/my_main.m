clear;
clc;
%Call predefined variables
my_variables;
%Define terminal time
TerminalT= 0;
ekfX = zeros(size(realValue));
for i = 1:length(measured_T)
    if i==1
       Rx = trX(1);
        Ry = trX(2);
        R = (Rx^2 + Ry^2)^0.5;
        traceSys.h = [R, 0]';
        traceSys.H = [Rx / R,       Ry / R,       0, 0, 0, 0;
                             -Ry / (R^2), Rx / (R^2), 0, 0, 0, 0];
        mZ = [measured_R(i), measured_Phi(i)]';
        [trX, ekfPk] = FncEKF(trX, mZ, ekfPk);
    else
        Rx = trX(1);
        Ry = trX(2);
        R = (Rx^2 + Ry^2)^0.5;
        traceSys.h = [R, atan2(Ry, Rx)]';
        traceSys.H = [Rx / R,       Ry / R,       0, 0, 0, 0;
                             -Ry / (R^2), Rx / (R^2), 0, 0, 0, 0];
        mZ = [measured_R(i), measured_Phi(i)]';
        [trX, ekfPk] = FncEKF(trX, mZ, ekfPk);
    end  
TerminalT = (i - 1) * simT;
    ekfX(:, i) = [TerminalT; trX; (Rx^2 + Ry^2)^0.5; atan2(Ry, Rx)];
end

figure;
plot(measured_T, real_X, 'k', measured_T, ekfX(2,:), 'r');
xlabel('Time(s)');
ylabel('X');
legend('realX','evaluatedX');

figure;
plot(measured_T, real_Y, 'k', measured_T, ekfX(3,:), 'r');
xlabel('Time(s)');
ylabel('Y');
legend('realY','evaluatedY');

figure;
plot(measured_T, real_Vx, 'k', measured_T, ekfX(4,:), 'r');
xlabel('Time(s)');
ylabel('V_x');
legend('realVx','evaluatedVx');

figure;
plot(measured_T, real_Vy, 'k', measured_T, ekfX(5,:), 'r');
xlabel('Time(s)');
ylabel('V_y');
legend('realVy','evaluatedVy');

figure;
plot(measured_T, real_Ax, 'k', measured_T, ekfX(6,:), 'r');
xlabel('Time(s)');
ylabel('A_x');
legend('realAx','evaluatedAx');

figure;
plot(measured_T,real_Ay, 'k', measured_T, ekfX(7,:), 'r');
xlabel('Time(s)');
ylabel('A_y');
legend('realAy','evaluatedAy');

figure;
plot(measured_T, real_R, 'k', measured_T, ekfX(8,:), 'r');
xlabel('Time(s)');
ylabel('R');
legend('realR','evaluatedR');

figure;
plot(measured_T, real_Phi, 'k', measured_T, ekfX(9,:), 'r');
xlabel('Time(s)');
ylabel('Phi');
legend('realPhi','evaluatedPhi');
% figure;
% plot(mT, trueR - ekfX(8, :), 'k');