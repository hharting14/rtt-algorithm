# RTT_ALGORITHM
Implementation of RTT Algorithm for robot motion plannig with MATLAB and CoppeliaSim. <br/>

I defined a "goal area" to simulate the set goal, in order to get faster results. <br/>
I bias the sampler towards the goal, if the sampled point is within the tolerance (0.01 - 0.02), then it is consider as the goal. <br/>
This way the algorithm is much faster and finds the goal in almost all cases. The algorithm can be found in the Modern Robotics book. <br/>

Other functions that I use: <br/>

Closest Node: outputs Xnearest, calculates EuclideanD of Xsamp and all the nodes. <br/>
LocalPlanner: outputs Xnew and if there is any collisions. Checks if the new segment line collides with any circle. <br/>
InterX: function available in Matlab to find intersections of two curves ("polyxpoly" also available). <br/>
MakePath: retrieves the path from the goal to the start of the graph. <br/>
Sampler: random uniform distribution number between -0.5 and 0.5. If the number is within the "goal area" then Xsamp = Xgoal. <br/>
RandCost/Hcost: random uniform distribution number within certain limits. <br/>
EuclideanD: Euclidean distance of two points in space. <br/>

CoppeliaSim example:
![ScreenshotCoppelia](https://user-images.githubusercontent.com/94148624/142066096-a4f7037d-1318-445a-8552-ac46beef0412.PNG)

MATLAB example 1:
![ScreenshotGoal1](https://user-images.githubusercontent.com/94148624/142066106-757cf730-9117-4ec9-8ef5-99248fdfc7a0.PNG)

MATLAB example 2:
![ScreenshotGoal2](https://user-images.githubusercontent.com/94148624/142066111-0c741753-8d50-4b21-8e5a-ba064f4e43f5.PNG)
