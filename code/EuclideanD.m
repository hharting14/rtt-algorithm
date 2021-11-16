function [d] = EuclideanD(X1,X2)
% Calculates Euclidean distance of two points in space
d = sqrt((X2(2,1)-X1(2,1))^2+(X2(1,1)-X1(1,1))^2);
end

