function [Xsamp] = Sampler(Xgoal,tol)
% Generate a random point Xsamp in the space [-0.5 0.5] [-0.5 0.5]
Xsamp(1,1) = rand(1);
Xsamp(2,1) = rand(1);
Xsamp(1,1) = Xsamp(1,1) - 0.5;
Xsamp(2,1) = Xsamp(2,1) - 0.5;

% Small bias towards the goal:
if Xsamp(1,1) >= Xgoal(1,1)-tol && Xsamp(2,1) >= Xgoal(2,1)-tol
    % If the sampler is really close to the goal we can take it as the goal
    Xsamp(1,1) = Xgoal(1,1);
    Xsamp(2,1) = Xgoal(2,1);
end
end

