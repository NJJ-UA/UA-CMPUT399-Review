function ev = cross_validate_svm(X,y,crange,n)
[~,ksize]=size(crange);
ev=zeros(ksize,1);
for c=crange
    error=0;
    for i=1:n
        fprintf('Start cross validate svm for c=%d,fold %d\n', c,i);
        s=size(y,2);
        range=(1+(i-1)*s/n:i*s/n);
        range_=setdiff(1:s,range);
        Xi=X(:,range);
        yi=y(range);
        Xi_=X(:,range_);
        yi_=y(range_);
        yip = predictSVM(Xi_, yi_, Xi, c);
        errorrate=sum(sign(abs(yip-yi)))/size(yi,2); 
        error=error+errorrate;
    end
    ev(c)=error/n;
end
