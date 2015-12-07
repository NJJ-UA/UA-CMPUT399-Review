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
trainlabels=trainlabels';
testlabels=testlabels(9:end);
testlabels=testlabels';
trainfeature=getfeaturehog(trainimages(17:end));
testfeature=getfeaturehog(testimages(17:end));

save('svmdatahog.mat','testfeature','testlabels','trainfeature','trainlabels');
toc