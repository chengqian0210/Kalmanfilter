function Xkf = KF_Function(InitX,Z,F,Q,H,R,P0)
%KAERMANFILTER 此处显示有关此函数的摘要
%参数说明： InitX:X的初始值,不知道初始值就输入零向量
%           Z:输入测量得到的数据
%           F：状态转移矩阵
%           H：观测矩阵
%           Q：协方差矩阵，反映状态受外界影响的大小
%           R：测量协方差矩阵，反映测量的精度，取决于传感器
%           P0
%读取数据
X=InitX;
%数据点数目
[~,s]=size(X);%获取数据维数
L=length(Z);
%初始化观测值矩阵 
Xkf=zeros(L,s);
Xkf(:,1)=X(:,1);%c初始期望等于初始值
P=P0;
%滤波 
for i=2:L
    Xn=F*(Xkf(i-1,:)');%一步预测
   P=F*P*F'+Q;%一步预测误差方差阵
    K=P*H'*inv(H*P*H'+R);;%滤波增益矩阵（权重）
    Xkf(i,:)=Xn+K*(Z(i,:)-H*Xn);%状态误差方差阵估计
    P=(eye(s)-K*H)*P;
end 
fig=figure(1);
set(fig,'position',[200 200 1200 500]);
hold on;
plot(Z(:,1),'-b.','MarkerSize',1);
hold on;
plot(Xkf(:,1),'-r','MarkerSize',1);
legend('观测轨迹','滤波轨迹');
end

