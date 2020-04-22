%×Óº¯Êı ÇóÅ·ÊÏ¾àÀë

function d=Dist(X1,X2);
	
if length(X2)<=2

   d=sqrt((X1(1)-X2(1))^2+(X1(3)-X2(2))^2);
	
else
	
   d=sqrt((X1(1)-X2(1))^2+(X1(3)-X2(3))^2);
	
end

