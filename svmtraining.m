close all;
clear all;

 
tic


Call=[0.00001 0.0001 0.001 0.01 0.1 1 10 100];


load('svmdatahog.mat');


labels=zeros(10,size(trainlabels,2));
svmmodels=cell(1,10);
for i=1:10
    fprintf('For number=%i \n',(i-1));
    indice=(trainlabels==(i-1));
    indice=indice*2-1;
    labels(i,:)=indice;
    
    [W,b]= svm_model(trainfeature,labels(i,:),Call,0.7);
    svmmodels{i}.W=W;
    svmmodels{i}.b=b;
end

save('svmmodels.mat','svmmodels');
toc