function c_logFit( );

clear;

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
dataName(21)={'KappaExp-1-2.csv'};
dataName(22)={'KappaExp-2-2.csv'};
dataName(23)={'KappaExp-3-2.csv'};
dataName(24)={'KappaExp-4-2.csv'};
dataName(25)={'KappaExp-5-2.csv'};
dataName(26)={'KappaExp-6-2.csv'};
dataName(27)={'KappaExp-7-2.csv'};
dataName(28)={'KappaExp-8-2.csv'};
dataName(29)={'KappaExp-9-2.csv'};
dataName(30)={'KappaExp-10-2.csv'};
dataName(31)={'KappaExp-11-2.csv'};
dataName(32)={'KappaExp-12-2.csv'};
dataName(33)={'KappaExp-13-2.csv'};
dataName(34)={'KappaExp-14-2.csv'};
dataName(35)={'KappaExp-15-2.csv'};
dataName(36)={'KappaExp-16-2.csv'};
dataName(37)={'KappaExp-17-2.csv'};
dataName(38)={'KappaExp-18-2.csv'};
dataName(39)={'KappaExp-19-2.csv'};
dataName(40)={'KappaExp-20-2.csv'};


parfor isub=1:40;

bootlog0=bootstrapfit(isub, dataName);

pse0(:,:,:,isub)=bootlog0.pse;
para0(:,:,isub)=bootlog0.para;
E0(:,:,isub)=bootlog0.E;

end;

bootlog.pse=squeeze(pse0);
bootlog.para=squeeze(para0);
bootlog.E=squeeze(E0);

savepath='./';
save(strcat(savepath,'bootlog.mat'),'bootlog');
clear bootlog;




function [bootlog0]=bootstrapfit(isub, dataName);

% import data
data=csvread(char(dataName(isub)));
sizData=size(data);

iboot=0;

while iboot<100; 
 
try    
    
[bootstat,bootsam] = bootstrp(1,@mean,[1:sizData(1)]);

for ntri=1:sizData(1);
data1(ntri,:)=data(bootsam(ntri,1),:);
end;


k.sub=isub;
       
k.xDis=data1(:,3);
k.yDis=data1(:,4);       
k.staDur=data1(:,5);
k.comDur=data1(:,6);
k.comLong=data1(:,8);



% fitting log-normal model
[a1]=fitLogModel(k); 
E0=LogFun(a1,k);

para0=a1;

w=a1(1);
sigtm=a1(2);
v0=0.09;
t0=1;

l1=[1 2 4 8 16 32]';
l2=1;
pse0(:,1)=(t0+0.5)*(((v0*t0+l1)./(v0*t0+l2)).^((1-w)/w))-t0;
pse0(:,2)=(t0+1)*(((v0*t0+l1)./(v0*t0+l2)).^((1-w)/w))-t0;


    iboot=iboot+1;
    
    bootlog0.para(:,iboot)=para0;
    bootlog0.pse(:,:,iboot)=pse0;
    bootlog0.E(:,iboot)=E0;
    

end;

end;


function [a1]=fitLogModel(k);

sizdata=size(k.staDur);

% begin to fit data
options=optimset('fminsearch');
options.TolX=0.001;
options.Display='final';


r0=rand(1,2)*0.09;
c0=[0.9 0.3]; 
c1=c0+r0

[a1,sfval,sexit,soutput]=fminsearch(@LogFun,c1,options,k);


function E=LogFun(a1,k)

sizets=size(k.staDur);

w=a1(1);
sigmtm=a1(2);
v0=0.09;
t0=1;



se1=w.*log(1+k.staDur./t0)+(1-w).*log(1+k.xDis/(v0*t0));
se2=w.*log(1+k.comDur./t0)+(1-w).*log(1+1/(v0*t0)); 

zscore=(se2-se1)./(sqrt(2*w)*sigmtm);

probs=normcdf(zscore,0,1);

for ii=1:sizets(1);
    if k.comLong(ii)==0;
        probs(ii)=1-probs(ii);
    end;
end;

p1= probs;

logPro=-log(p1);

E=sum(logPro);





