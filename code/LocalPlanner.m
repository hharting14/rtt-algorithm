function [Xnew,collisions] = LocalPlanner(Xnearest,Xsamp,dlim,Obstacles)
% Make a straight line according to the max distance allowed
Xnew = [];
collisions = [];
m = (Xsamp(2,1)-Xnearest(2,1))/(Xsamp(1,1)-Xnearest(1,1));

% Segment between Xnearest and Xsamp:
x = Xnearest(1,1):0.01:Xsamp(1,1);
ylin = m * (x - Xnearest(1,1)) + Xnearest(2,1);

% Verifying distance condition:
for i = 1 : length(x) 
    d = sqrt((ylin(i)-Xnearest(2,1))^2+(x(i)-Xnearest(1,1))^2);
    if d <= dlim  
        dnew = d;
        Xnew(1,1) = x(i); 
        Xnew(2,1) = ylin(i);
    end
end

if ~isempty(Xnew)
    % Make new segment with the max distance allowed with the same dir of Xsamp:
    dif = Xnew(1,1) - Xnearest(1,1);
    tam = 100;
    xn = Xnearest(1,1):dif/100:Xnew(1,1);
    % xn = Xnearest(1,1):0.01:Xnew;
    ynlin = m * (xn - Xnearest(1,1)) + Xnearest(2,1);

    % Collision checking:
    th = 0:pi/50:2*pi;
    P = [];
    intersections = [];
    collisions = [];
    r = Obstacles.diameter/2;

    for j = 1 : height(Obstacles)  
        xunit = r(j) * cos(th) + Obstacles.xc(j);
        yunit = r(j) * sin(th) + Obstacles.yc(j);
        hold on
        plot(xunit, yunit); xlim([-0.5 0.5]); ylim([-0.5 0.5]); grid on
        % Check collision with obstacles
        P = InterX([xn;ynlin],[xunit;yunit]);
            if ~isempty(P)        
                collisions = horzcat(collisions,P);
            end
    end

        collisions = sort(collisions,2);

        if isempty(collisions)
            % There are no collisions, available path
            plot(xn,ynlin); xlim([-0.5 0.5]); ylim([-0.5 0.5]); grid on
            return
        else
            % There is a collision, cannot make it this way
            dnew = 0;
            Xnew = [];
            return
        end
end
end