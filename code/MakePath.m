function [pathcoordinates,pathnodes] = MakePath(nodes,edges,Xnew,Xstart)
% Outputs a path from start to goal
pathcoordinates = Xnew;
curr = Xnew;
currnumber = length(nodes.number);
parent = 0;
pathnodes = length(nodes.number);

while curr ~= Xstart
    % Go to edges and retrieve its predecesor                                   
    parent = edges.ID1(currnumber-1);            
    curr(1,1) = nodes.x(parent);
    curr(2,1) = nodes.y(parent);          
    pathcoordinates = [pathcoordinates,curr];
    pathnodes = horzcat(pathnodes,parent);
    currnumber = parent;              
end

% Flip path: start to goal
pathcoordinates = flip(pathcoordinates,2);
pathnodes = flip(pathnodes);
end