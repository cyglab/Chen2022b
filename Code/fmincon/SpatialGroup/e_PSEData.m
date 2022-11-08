clear;

load('PSE.mat');
a1(:,:)=squeeze(PSE.pse(1,:,:));
a2(:,:)=squeeze(PSE.pse(2,:,:));

b1(:,:)=squeeze(PSE.sd(1,:,:));
b2(:,:)=squeeze(PSE.sd(2,:,:));

clear PSE;

c1=a1';
c2=a2';

psedata(:,1:6)=a1';
psedata(:,7:12)=a2';

sddata(:,1:6)=b1';
sddata(:,7:12)=b2';







