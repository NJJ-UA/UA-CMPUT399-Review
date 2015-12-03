close all;
clear all;
tic
fileID=fopen('t10k-labels.idx1-ubyte');
testlabels=fread(fileID);

fileID=fopen('t10k-images.idx3-ubyte');
testimages=fread(fileID);

fileID=fopen('train-labels.idx1-ubyte');
trainlabels=fread(fileID);

fileID=fopen('train-images.idx3-ubyte');
trainimages=fread(fileID);

trainlabels=trainlabels(9:end);
testlabels=testlabels(9:end);
trainfeature=getfeature(trainimages(17:end));
testfeature=getfeature(testimages(17:end));
kdtree=vl_kdtreebuild(trainfeature);

[index,dist]=vl_kdtreequery(kdtree,trainfeature,testfeature);%'MaxNumComparisons',1024);

estimate=trainlabels(index);

error=mean(abs(estimate-testlabels));
errorrate=sum(sign(abs(estimate-testlabels)))/size(testlabels,1);
toc

westgrid

