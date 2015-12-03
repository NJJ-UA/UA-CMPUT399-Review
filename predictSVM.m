function estimate=predictSVM(trainfeature,trainlabels,testfeature,c)
[featuresize,~]=size(trainfeature);
Aw=zeros(featuresize,10);
Abias=zeros(1,10);
for i=0:9
    indice=(trainlabels==i);
    
    labels=bsxfun(@minus,indice.*2,1);
    [w, bias] = trainLinearSVM(trainfeature,labels, c);
    Aw(:,i+1)=w;
    Abias(i+1)=bias;
end


scores = bsxfun(@plus,Aw'*testfeature ,Abias');


[~,I]=max(scores);
estimate=bsxfun(@minus,I,1);

end