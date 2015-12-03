function [W,b,c] = cross_validate_svm1svmclass(Xpos,Xneg,Call,trainpercent)


npos=size(Xpos,1);
nneg=size(Xneg,1);

ypos=ones(npos,1);
yneg=-ones(nneg,1);

ntrainpos=round(trainpercent*npos);
ntrainneg=round(trainpercent*nneg);

indpostrain=1:ntrainpos; 
indposval=setdiff(1:npos,indpostrain);
indnegtrain=1:ntrainneg;
indnegval=setdiff(1:nneg,indnegtrain);

Xtrain=[Xpos(indpostrain,:); Xneg(indnegtrain,:)];
ytrain=[ypos(indpostrain); yneg(indnegtrain)];
Xval=[Xpos(indposval,:); Xneg(indnegval,:)];
yval=[ypos(indposval); yneg(indnegval)];




epsilon = .000001;
kerneloption= 1; % degree of polynomial kernel (1=linear)
kernel='poly';   % polynomial kernel
verbose = 0;


for i=1:length(Call)
  tic
  C=Call(i);

  [Xsup,yalpha,b,~]=svmclass(Xtrain,ytrain,C,epsilon,kernel,kerneloption,verbose);
  [~,acctrain,~]=svmvalmod(Xtrain,ytrain,Xsup,yalpha,b,kernel,kerneloption);
  [~,accval,~]=svmvalmod(Xval,yval,Xsup,yalpha,b,kernel,kerneloption);
  

  fprintf('C=%1.5f | Training accuracy: %1.3f; validation accuracy: %1.3f \n',C,acctrain,accval);

  acc(i)=accval;
  toc
end

[~,I]=max(acc);
c=Call(I);
[Xsup,yalpha,b,~]=svmclass([Xpos;Xneg],[ypos;yneg],c,epsilon,kernel,kerneloption,verbose);
W = (yalpha'*Xsup)';
end
