function obstacles = importObstacles(filename, dataLines)
%IMPORTFILE Import data from a text file
%  OBSTACLES = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the data as a table.
%
%  OBSTACLES = IMPORTFILE(FILE, DATALINES) reads data for the specified
%  row interval(s) of text file FILENAME. Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  obstacles = importfile("C:\Users\Spark Trade Center\Documents\ModernRobotics\Course4\Week2\obstacles.csv", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 18-Sep-2020 13:07:11

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["xc", "yc", "diameter"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
obstacles = readtable(filename, opts);

end