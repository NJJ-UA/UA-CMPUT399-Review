close all;
clear all;

setup;
tic


Call{1}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{2}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{3}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{4}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{5}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{6}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{7}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{8}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{9}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
Call{10}=[100 10 1 0.1 0.01 0.001 0.0001 0.00001];
%c 2
%error 0.499500000000000
%errorrate 0.132100000000000
load('svmdata2.mat');

trainfeature=trainfeature';
trainlabels=trainlabels';

testfeature=testfeature';
testlabels=testlabels';



for i=1:10
    indice=(trainlabels==i);
    traincell{i}.Xpos=trainfeature(indice,:);
    traincell{i}.Xneg=trainfeature(setdiff(1:size(trainfeature,1),indice),:);
end



bestmodel=zeros(2,10);
testscore=zeros(size(testlabels,1),10);
for i=1:10
    [W,b,~]= cross_validate_svm1svmclass(traincell{i}.Xpos,traincell{i}.Xneg,Call{i},0.5);
    bestmodel(:,i)=[W;b];
    
    score=testfeature*W+b;
    testscore(:,i)=score;
   
end
[~,I]=max(testscore,[],2);

I= bsxfun(@minus,I ,1);


errorrate=sum(sign(abs(I-testlabels)))/size(testlabels,1);
toc