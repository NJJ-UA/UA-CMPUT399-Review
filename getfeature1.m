function F=getfeature1(A)
level = graythresh(A);
A = im2bw(A,level);
F=reshape(A,[784,size(A,1)/784]);
end
