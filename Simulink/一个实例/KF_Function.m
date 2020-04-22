function Xkf = KF_Function(InitX,Z,F,Q,H,R,P0)
%KAERMANFILTER �˴���ʾ�йش˺�����ժҪ
%����˵���� InitX:X�ĳ�ʼֵ,��֪����ʼֵ������������
%           Z:��������õ�������
%           F��״̬ת�ƾ���
%           H���۲����
%           Q��Э������󣬷�ӳ״̬�����Ӱ��Ĵ�С
%           R������Э������󣬷�ӳ�����ľ��ȣ�ȡ���ڴ�����
%           P0
%��ȡ����
X=InitX;
%���ݵ���Ŀ
[~,s]=size(X);%��ȡ����ά��
L=length(Z);
%��ʼ���۲�ֵ���� 
Xkf=zeros(L,s);
Xkf(:,1)=X(:,1);%c��ʼ�������ڳ�ʼֵ
P=P0;
%�˲� 
for i=2:L
    Xn=F*(Xkf(i-1,:)');%һ��Ԥ��
   P=F*P*F'+Q;%һ��Ԥ��������
    K=P*H'*inv(H*P*H'+R);;%�˲��������Ȩ�أ�
    Xkf(i,:)=Xn+K*(Z(i,:)-H*Xn);%״̬���������
    P=(eye(s)-K*H)*P;
end 
fig=figure(1);
set(fig,'position',[200 200 1200 500]);
hold on;
plot(Z(:,1),'-b.','MarkerSize',1);
hold on;
plot(Xkf(:,1),'-r','MarkerSize',1);
legend('�۲�켣','�˲��켣');
end

