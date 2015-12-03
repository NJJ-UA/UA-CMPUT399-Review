function [W,b,c] = cross_validate_svm1(Xpos,Xneg,Call,trainpercent)

maxIter=1000;


npos=size(Xpos,2);
nneg=size(Xneg,2);

ypos=ones(1,npos);
yneg=-ones(1,nneg);

ntrainpos=round(trainpercent*npos);
ntrainneg=round(trainpercent*nneg);

indpostrain=1:ntrainpos; 
indposval=setdiff(1:npos,indpostrain);
indnegtrain=1:ntrainneg;
indnegval=setdiff(1:nneg,indnegtrain);

Xtrain=[Xpos(:,indpostrain)  Xneg(:,indnegtrain)];
ytrain=[ypos(indpostrain)  yneg(indnegtrain)];
Xval=[Xpos(:,indposval) Xneg(:,indnegval)];
yval=[ypos(indposval)  yneg(indnegval)];






acc=zeros(1,length(Call));
for i=1:length(Call)
  
  C=Call(i);

  
  [W,b] = vl_svmtrain(double(Xtrain), ytrain,C,'MaxNumIterations',maxIter);
  score=W'*Xval+b;
  accval= mean((score>0)*2-1==yval);
  

  fprintf('C=%1.5f | validation accuracy: %1.3f \n',C,accval);

  acc(i)=accval;
  
end

[~,I]=max(acc);
c=Call(I);
fprintf('Best C=%1.5f\n',c);
[W,b] = vl_svmtrain(double([Xpos Xneg]), [ypos yneg],c,'MaxNumIterations',maxIter);

end
