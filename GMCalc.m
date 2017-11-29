function res = GMCalc(Test,Result)
size2=size(Test,2);
TP=sum(Test(:,size2).*Result)/sum(Test(:,size2));
TN=sum((1-Test(:,size2)).*(1-Result))/sum(1-Test(:,size2));
res=sqrt(TP*TN);
end