close all;
clear all;

%svmdata1.mat
%C 10
%error 0.429100000000000
%errorrate 0.124800000000000
tic

load('svmdata2.mat');


%svmdata2.mat
%C 10
%errorrate 0.111900000000000
[featuresize,trainsize]=size(trainfeature);
Aw=zeros(featuresize,10);
Abias=zeros(1,10);
for i=0:9
    indice=(trainlabels==i);
    
    labels=bsxfun(@minus,indice.*2,1);
    C=10;
    [w, bias] = trainLinearSVM(trainfeature,labels, C);
    Aw(:,i+1)=w;
    Abias(i+1)=bias;
end


scores = bsxfun(@plus,Aw'*testfeature ,Abias');


[~,I]=max(scores);
estimate=bsxfun(@minus,I,1);

error=mean(abs(estimate-testlabels));
errorrate=sum(sign(abs(estimate-testlabels)))/size(testlabels,2);
toc