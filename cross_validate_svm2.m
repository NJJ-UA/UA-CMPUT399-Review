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






acc=zeros(3,length(Call));
for i=1:length(Call)
  
  C=Call(i);

  
  [W,b] = vl_svmtrain(double(Xtrain), ytrain,C,'MaxNumIterations',maxIter);
  score=W'*Xval+b;
  accval= mean((score>0)*2-1==yval);
  
  score_train=W'*Xtrain+b;
  acctrain= mean((score_train>0)*2-1==ytrain);

  fprintf('C=%1.5f | train accuracy: %1.3f |validation accuracy: %1.3f \n',C,acctrain,accval);

  acc(1,i)=accval;
  acc(2,i)=acctrain;
  acc(3,i)=C;
end

m=max(acc(1,:));
acc=acc(:,acc(1,:)==m);
[~,m]=max(acc(2,:));
c=acc(3,m);
fprintf('Best C=%1.5f\n',c);
[W,b] = vl_svmtrain(double([Xpos Xneg]), [ypos yneg],c,'MaxNumIterations',maxIter);

end
