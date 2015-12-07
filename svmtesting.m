close all;
clear all;

 
tic


load('svmdatahog.mat');
load('svmmodels.mat');

testscore=zeros(size(testlabels,2),10);
for i=1:10
   
    
    W=svmmodels{i}.W;
    b=svmmodels{i}.b;
    
    
    
    
    score=W'*testfeature+b;
    testscore(:,i)=score;
   
end



[M,I]=max(testscore,[],2);

I= I-1;
I=I';

errorrate=sum(sign(abs(I-testlabels)))/size(testlabels,2);
disp(errorrate);
toc