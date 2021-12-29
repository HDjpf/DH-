function [A] = ran_romatrix(joint,m,n)
% This function can be used to get position and direction of ee
% m to n is a range
A=eye(4);
for i =m:n
    A=A*get_romatrix(joint(i));
end

