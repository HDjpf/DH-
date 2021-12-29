function [A] = get_romatrix(joint)
% input a vector which include parameters of each link
theta =  joint.parameter(1);
d = joint.parameter(2);
alpha = joint.parameter(3);
a = joint.parameter(4);
% according to the parameters in DH-table
% we can get transformation matrix in each rotation or translation
A=[cos(theta)           , -sin(theta)          , 0          , a             ;
   sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -d*sin(alpha) ;
   sin(alpha)*sin(theta), cos(theta)*sin(alpha), cos(alpha) , d*cos(alpha)  ;
   0                    , 0                    , 0          , 1            ];
end

