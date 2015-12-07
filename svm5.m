close all;
clear all;

setup;
tic

%0.031700000000000


load('svmdatarp.mat');

testfeature=testfeature';
trainfeature=trainfeature';



SVMModels = cell(10,1);

for i = 1:10;
    tic
    index = trainlabels==(i-1);
    SVMModels{i} = fitcsvm(trainfeature,index,'Standardize',true,...
        'KernelFunction','rbf','KernelScale','auto');
    toc
end

Scores=zeros(size(testlabels,2),10);
for i = 1:10;
    [~,score] = predict(SVMModels{i},testfeature);
    Scores(:,i) = score(:,2); % Second column contains positive-class scores
end

[~,maxScore] = max(Scores,[],2);
I=maxScore-1;

I=I';

errorrate=sum(sign(abs(I-testlabels)))/size(testlabels,2);
toc