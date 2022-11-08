function PSE=a_PSEfit(  );

%read data from txt files


dataName(1)={'KappaExp-1-1.csv'};
dataName(2)={'KappaExp-2-1.csv'};
dataName(3)={'KappaExp-3-1.csv'};
dataName(4)={'KappaExp-4-1.csv'};
dataName(5)={'KappaExp-5-1.csv'};
dataName(6)={'KappaExp-6-1.csv'};
dataName(7)={'KappaExp-7-1.csv'};
dataName(8)={'KappaExp-8-1.csv'};
dataName(9)={'KappaExp-9-1.csv'};
dataName(10)={'KappaExp-10-1.csv'};
dataName(11)={'KappaExp-11-1.csv'};
dataName(12)={'KappaExp-12-1.csv'};
dataName(13)={'KappaExp-13-1.csv'};
dataName(14)={'KappaExp-14-1.csv'};
dataName(15)={'KappaExp-15-1.csv'};
dataName(16)={'KappaExp-16-1.csv'};
dataName(17)={'KappaExp-17-1.csv'};
dataName(18)={'KappaExp-18-1.csv'};
dataName(19)={'KappaExp-19-1.csv'};
dataName(20)={'KappaExp-20-1.csv'};
dataName(21)={'KappaExp-21-1.csv'};
dataName(22)={'KappaExp-22-1.csv'};
dataName(23)={'KappaExp-23-1.csv'};
dataName(24)={'KappaExp-1-2.csv'};
dataName(25)={'KappaExp-2-2.csv'};
dataName(26)={'KappaExp-3-2.csv'};
dataName(27)={'KappaExp-4-2.csv'};
dataName(28)={'KappaExp-5-2.csv'};
dataName(29)={'KappaExp-6-2.csv'};
dataName(30)={'KappaExp-7-2.csv'};
dataName(31)={'KappaExp-8-2.csv'};
dataName(32)={'KappaExp-9-2.csv'};
dataName(33)={'KappaExp-10-2.csv'};
dataName(34)={'KappaExp-11-2.csv'};
dataName(35)={'KappaExp-12-2.csv'};
dataName(36)={'KappaExp-13-2.csv'};
dataName(37)={'KappaExp-14-2.csv'};
dataName(38)={'KappaExp-15-2.csv'};
dataName(39)={'KappaExp-16-2.csv'};
dataName(40)={'KappaExp-17-2.csv'};
dataName(41)={'KappaExp-18-2.csv'};
dataName(42)={'KappaExp-19-2.csv'};
dataName(43)={'KappaExp-20-2.csv'};
dataName(44)={'KappaExp-21-2.csv'};
dataName(45)={'KappaExp-22-2.csv'};
dataName(46)={'KappaExp-23-2.csv'};



for isub=1:46;
    %load data
    
    try
data=csvread(char(dataName(isub)));

sizData=size(data);

xDis=[1 2 4 8 16 32];
yDis=[3];
t1=[0.5 1];


sxDis=size(xDis);
syDis=size(yDis);
stDis=size(t1);


nc1=0;
nc2=0;

for i1=1:sxDis(2);
    for j1=1:syDis(2);
        for k1=1:stDis(2);
             nt=0; 
             
            for l1=1:sizData(1);
                if data(l1,3)==xDis(i1) && data(l1,4)==yDis(j1) && data(l1,5)==t1(k1);
                    nt=nt+1;
                    tempdata(nt,:)=data(l1,:);
                end;
            end;
            maxda=max(tempdata(:,6));
            
            
            if tempdata(1,5)==0.5;
                xtim=0:0.1:(maxda+0.1);
            else xtim=0:0.2:(maxda+0.2);
            end;
            
            dt=tempdata(1,5)/5;
            
            xsiz=size(xtim);
            dsiz=size(tempdata);
            
            ytim=zeros(xsiz);
            ntim=zeros(xsiz);
            
            for ii=1:dsiz(1);
                for jj=1:xsiz(2);
                    if tempdata(ii,6)>=(xtim(jj))&& tempdata(ii,6) < (xtim(jj)+dt);
                        ytim(jj)=ytim(jj)+tempdata(ii,8);
                        ntim(jj)=ntim(jj)+1;
                    end;
                end;
            end;
            
            rtim=ytim./ntim;  

          
            
if tempdata(1,5)==0.5;
    nc1=nc1+1;
x=xtim;
y=rtim;
modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [0.5 0.3];
try
coefEsts = nlinfit(x, y, modelFun, startingVals);
catch
coefEsts = [0 0];  
end;
pse(1,nc1,isub)=coefEsts(1);
sd(1,nc1,isub)=coefEsts(2);
 end;    
 
 

if tempdata(1,5)==1;
    nc2=nc2+1;
x=xtim;
y=rtim;
modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1 0.6];
try
coefEsts = nlinfit(x, y, modelFun, startingVals);
catch
coefEsts = [0 0];
end;
pse(2,nc1,isub)=coefEsts(1);
sd(2,nc1,isub)=coefEsts(2);


 end; 
            
        end;
    end;
end;

end;
end;
PSE.pse=pse;
PSE.sd=sd;

savepath='./';
save(strcat(savepath,'PSE.mat'),'PSE');
