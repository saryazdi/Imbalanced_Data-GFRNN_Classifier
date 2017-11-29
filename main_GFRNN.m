clear all
close all
clc
% ~~~~~~ CODE STARTS HERE ~~~~~~~~
Sample = importdata('Example_Imbalanced_Dataset_Train.mat');
Test= importdata('Example_Imbalanced_Dataset_Test.mat');
[size1 size2] = size(Sample);
IR = sum(Sample(:,size2)==0)/sum(Sample(:,size2)==1); % Imbalance Ratio
% Train
Distances = pdist2(Sample(:,1:size2-1),Sample(:,1:size2-1)); %sotune avale Distances, faseleye tak take azaye Sample az avalin dade Test
Radius = 0.5*size1*(size1-1)*sum(Distances(:));
% CLASSIFICATION
TestDistances = pdist2(Sample(:,1:size2-1),Test(:,1:size2-1));
for i=1:size(TestDistances,2)
    Temp = sortrows([TestDistances(:,i),Sample(:,size2)]);
    GFRNN_M = Temp(Temp(:,1)<Radius,2)*IR; % Positive Samples Mass
    GFRNN_M(GFRNN_M==0) = -1; % Negative Samples Mass
    GFRNN_class = GFRNN_M./(Temp(Temp(:,1)<Radius,1).^2); % Gravitational Force Calculation
    Result(i,1) = double(sum(GFRNN_class)>0);
end
% GEOMETRIC MEAN
GM = GMCalc(Test,Result);
fprintf('GM = %2.2f%%\n',GM*100)