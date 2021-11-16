% RRT Algorithm 
clc
clear
tic

% Parameters
maxtreeSize = 700;      % Max number of nodes
dlim = 0.18;            % Max distance of the segment made by the local planner
tol = 0.02;             % Tolerance. Simulates a "goal area";
i = 2;                  % Counter for nodes
found = 0;              % Found goal

% Initializing tables
nodes = table('Size',[1 4],'VariableTypes',{'double','double','double','double'},'VariableNames',{'number','x','y','hcost'});
edges = table('Size',[1 3],'VariableTypes',{'double','double','double'},'VariableNames',{'ID2','ID1','cost'});
node2add = table('Size',[1 4],'VariableTypes',{'double','double','double','double'},'VariableNames',{'number','x','y','hcost'});
edge2add = table('Size',[1 3],'VariableTypes',{'double','double','double'},'VariableNames',{'ID2','ID1','cost'});

% Importing obstacles
Obstacles = importObstacles('obstacles.csv');

% Initializing variables
Xstart = [-0.5;-0.5]; 
Xgoal = [0.5;0.5];
Xnew = []; 
collisions = []; 
pathcoordinates = [];

% Putting Xstart in nodes
nodes.x(1) = Xstart(1,1); 
nodes.number(1) = 1;
nodes.y(1) = Xstart(2,1);
nodes.hcost(1) = RandHCost();

% Algorithm 
while height(nodes) < maxtreeSize
    Xnew = [];
    while isempty(Xnew)
        Xsamp = Sampler(Xgoal,tol);
        [Xnearest,I] = ClosestNode(nodes,Xsamp);
        [Xnew,collisions] = LocalPlanner(Xnearest,Xsamp,dlim,Obstacles);
    end
    if isempty(collisions) && ~isempty(Xnew)
        % Appending Xnew to nodes
        node2add.number(1) = i;     
        node2add.x(1) = Xnew(1,1);       
        node2add.y(1) = Xnew(2,1); 
        node2add.hcost(1) = RandHCost();
        nodes = vertcat(nodes,node2add);
        % Creating edge between Xnearest and Xnew
        edge2add.ID2(1) = i;
        edge2add.ID1(1) = I;
        edge2add.cost(1) = RandCost();
        edges = vertcat(edges,edge2add);
        i = i+1;
        if Xnew == Xgoal    
            found = 1;
            toc
            break
        end
    end
end

% Removing the first line of zeros of edges
edges(1,:) = [];
[pathcoordinates,pathnodes] = MakePath(nodes,edges,Xnew,Xstart);

% Plotting the nodes in space: blue if goal was found it, red otherwise
if ~isempty(pathcoordinates)
    if found == 1
        plot(pathcoordinates(1,:),pathcoordinates(2,:),'ko','MarkerSize',7,'MarkerEdgeColor','k','MarkerFaceColor','b'); xlim([-0.5 0.5]); ylim([-0.5 0.5]); grid on
        hold on 
    end
    if found == 0
        plot(pathcoordinates(1,:),pathcoordinates(2,:),'ko','MarkerSize',7,'MarkerEdgeColor','k','MarkerFaceColor','r'); xlim([-0.5 0.5]); ylim([-0.5 0.5]); grid on
        hold on
    end
end

% Finally write csv files with path, nodes and edges
csvwrite('path.csv', pathnodes); 
writetable(nodes,'nodes.csv')
writetable(edges,'edges.csv')
toc