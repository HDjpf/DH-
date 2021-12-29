function R=RPY2R(rpy)
%cr=cos(rpy(3));sr=sin(rpy(3));
%cp=cos(rpy(2));sp=sin(rpy(2));
%cy=cos(rpy(1));sy=sin(rpy(1));
R=sym(eye(3));
R(1,1)=cos(rpy(2))*cos(rpy(3));
R(1,2)=cos(rpy(3))*sin(rpy(2))*sin(rpy(1)) - cos(rpy(1))*sin(rpy(3));
R(1,3)=sin(rpy(3))*sin(rpy(1)) + cos(rpy(3))*cos(rpy(1))*sin(rpy(2));
R(2,1)=cos(rpy(2))*sin(rpy(3));
R(2,2)=cos(rpy(3))*cos(rpy(1)) + sin(rpy(2))*sin(rpy(3))*sin(rpy(1));
R(2,3)=cos(rpy(1))*sin(rpy(2))*sin(rpy(3)) - cos(rpy(3))*sin(rpy(1));
R(3,1)=-sin(rpy(2));
R(3,2)=cos(rpy(2))*sin(rpy(1));
R(3,3)=cos(rpy(2))*cos(rpy(1));
end