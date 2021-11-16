function [Xnearest,I] = ClosestNode(nodes,Xsamp)
% Outputs the closest node from the tree to Xsamp
d = zeros(1,height(nodes));
for i = 1 : height(nodes)
    Xnode(1,1) = nodes.x(i);
    Xnode(2,1) = nodes.y(i);
    d(i) = EuclideanD(Xnode,Xsamp);      
end
[dmin,I] = min(d);
Xnearest(1,1) = nodes.x(I);
Xnearest(2,1) = nodes.y(I);
end