function F=getfeaturehog(A)
cellsize=4;
A=reshape(A,[28,28,size(A,1)/784]);
F=zeros(31*28*28/(cellsize*cellsize),size(A,3));
for i=1:size(A,3)
    hog=vl_hog(im2single(A(:,:,i)),cellsize);
    hog=reshape(hog,[31*28*28/(cellsize*cellsize),1]);
    F(:,i)=hog;
end
end