function [W,b] = svm_model(X,y,Call,trainpercent)


train=1:(size(X,2)*trainpercent);
val=setdiff(1:size(X,2),train);
Xtrain=X(:,train);
ytrain=y(:,train);
Xval=X(:,val);
yval=y(:,val);

acc=zeros(3,length(Call));
for i=1:length(Call)
  
    C=Call(i);
    [W, b] = trainLinearSVM(Xtrain,ytrain, C);
 
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
m=max(acc(2,:));
acc=acc(:,acc(2,:)==m);

c=acc(3,1);
fprintf('Best C=%1.5f\n',c);

[W, b] = trainLinearSVM(X,y,c);

end
