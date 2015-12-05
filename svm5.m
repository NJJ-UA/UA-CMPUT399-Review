close all;
clear all;

setup;
tic




load('svmdatahog.mat');

testfeature=testfeature';
trainfeature=trainfeature';



SVMModels = cell(10,1);

for i = 1:10;
    tic
    index = trainlabels==(i-1);
    SVMModels{i} = fitcsvm(trainfeature,index,'ClassNames',logical([0,1]),'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1,'IterationLimit',1000);
    toc
end

Scores=zeros(size(testlabels,2),10);
for i = 1:10;
    [~,score] = predict(SVMModels{i},testfeature);
    Scores(:,i) = score(:,2); % Second column contains positive-class scores
end

[~,maxScore] = max(Scores,[],2);
% [M,I]=max(testscore,[],2);
% good=M>0;
% I= bsxfun(@minus,I ,1);
% 
% I=I';
% 
% errorrate=sum(sign(abs(I(good)-testlabels(good))))/size(testlabels(good),2);
toc