function rpy=R2RPY(R)
rpy=zeros(3,1);
if(1-abs(R(3,1))<0)
    if(R(3,1)<0)
        rpy(2)=pi/2;
    else
        rpy(2)=-pi/2;
    end
    rpy(1)=atan2(-R(2,3),R(2,2));
    rpy(3)=0;
else
    rpy(2)=-asin(R(3,1));
    rpy(3)=atan2(R(2,1),R(1,1));
    rpy(1)=atan2(R(3,2),R(3,3));
end

end