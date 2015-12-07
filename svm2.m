close all;
clear all;

 
tic
%c 4
%error 0.541900000000000
%errorrate 0.170000000000000
%load('svmdata1.mat');


%c 2
%error 0.499500000000000
%errorrate 0.132100000000000
load('svmdatahog.mat');

Call=1:10;
ev = cross_validate_svm(trainfeature,trainlabels,Call,10);

[~,C]=min(ev);
C=Call(C);
estimate=predictSVM(trainfeature,trainlabels,testfeature,C);

errorrate=sum(sign(abs(estimate-testlabels)))/size(testlabels,2);
toc