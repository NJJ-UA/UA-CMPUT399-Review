close all;
clear all;

setup;
tic

%valfrac 0.8
%errorrate 0.101092202184404


%valfrac 0.9
%errorrate 0.034554537885096

% Call{1}=[0.00001 0.00005 0.0001 0.0005 0.001];
% Call{2}=[0.00001 0.00005 0.0001 0.0005 0.001];
% Call{3}=[0.00001 0.00005 0.0001 0.0005 0.001];
% Call{4}=[0.00001 0.00005 0.0001 0.0005 0.001];
% Call{5}=[0.000001 0.00001 0.00005 0.0001 0.0005 0.001];
% Call{6}=[0.00001 0.00005 0.0001 0.0005 0.001];
% Call{7}=[0.00001 0.00005 0.0001 0.0005 0.001];
% Call{8}=[0.001  0.005 0.01 0.05 0.1];
% Call{9}=[0.000001 0.00001 0.0001 0.001 0.01 0.1];
% Call{10}=[1 2 3 4 5 6 7 8 9 10];


%valfrac 0.8
%errorrate 0.046815834767642

%valfrac 0.9
%errorrate 0.013098649201801

%max it 1000000
%valfrac 0.9
%errorrate 0.001165501165501

Call{1}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{2}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{3}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{4}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{5}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{6}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{7}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{8}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{9}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];
Call{10}=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];



load('svmdatahog.mat');





for i=1:10
    indice=(trainlabels==(i-1));
    traincell{i}.Xpos=trainfeature(:,indice);
    traincell{i}.Xneg=trainfeature(:,setdiff(1:size(trainfeature,2),indice));
end



bestmodel=zeros(2,10);
testscore=zeros(size(testlabels,2),10);
for i=1:10
    fprintf('For number=%i \n',(i-1));
    [W,b,~]= cross_validate_svm1(traincell{i}.Xpos,traincell{i}.Xneg,Call{i},0.9);
    %bestmodel(:,i)=[W;b];
    
    score=W'*testfeature+b;
    testscore(:,i)=score;
   
end
[M,I]=max(testscore,[],2);

I= bsxfun(@minus,I ,1);

I=I';

errorrate=sum(sign(abs(I-testlabels(good))))/size(testlabels,2);
toc