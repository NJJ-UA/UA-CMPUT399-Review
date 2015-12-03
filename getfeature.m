function F=getfeature(A)
F=reshape(A,[784,size(A,1)/784]);
F(F<128)=0;
F(F>=128)=1;
end
