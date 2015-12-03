function I=mygetimage(A,index)
I=A(index*784-767:index*784+16);
I=reshape(I,[28,28]);
I=I';
end