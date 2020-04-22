function [eX, ePk] = FncEKF(xk, zk, Pk)
global traceSys;

%States Updating--------------%
xk_pr = traceSys.A * xk;
Pk_pr = traceSys.A * Pk * traceSys.A' + traceSys.Qk;
%-------------------------------%

%Time Updating----------------%
eK = (Pk_pr * traceSys.H') / (traceSys.H * Pk_pr * traceSys.H' + traceSys.Rk);
ePk = (eye(6) - eK * traceSys.H) * Pk_pr;
eX = xk_pr + eK * (zk - traceSys.h);
%-------------------------------%
end