function e_plotExp2(  );



clear



load('./bootlogCon.mat')

sub=[1:18 20];
sub2=[1:18 20]+20;

%sub=[5];
%sub2=[5]+20;

sizmPse=size(sub);
a=mean(bootlog.pse(:,:,:,:),3);
log_m=mean(a(:,:,:,sub),4);
log_se=std(a(:,:,:,sub),0,4)/sqrt(sizmPse(2));



x=[1 2 4 8 16 32];

subplot(1,2,1);



plt.m=log_m(:,1,1,1);
plt.se=log_se(:,1,1,1);
plt.color=[72 143 49]/255;
plt.xrange=[0 35];
plt.yrange=[0.4 0.9];
plt.x=x;
d_plotpic(plt);

hold on;

data=xlsread('pre05.xlsx');
mPse(1,:)=mean(data(sub,:),1)';

sizdat=size(data(sub,:));
sePse(1,:)=std(data(sub,:),0,1)/sqrt(sizdat(1));

errorbar(x,mPse(1,:),sePse(1,:),'^','linewidth',2,'Color',[72 143 49]/255, 'MarkerSize',5,...
   'MarkerEdgeColor',[72 143 49]/255,'MarkerFaceColor',[72 143 49]/255);
hold on;



set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')
%=================================
%=================================

subplot(1,2,2);




plt.m=log_m(:,2);
plt.se=log_se(:,2);
plt.color=[72 143 49]/255;
plt.xrange=[0 35];
plt.yrange=[0.9 1.5];
plt.x=x;
d_plotpic(plt);

hold on;

data2=xlsread('pre10.xlsx');
mPse(2,:)=mean(data2(sub,:),1)';

sizdat=size(data2(sub,:));
sePse(2,:)=std(data2(sub,:),0,1)/sqrt(sizdat(1));

errorbar(x,mPse(2,:),sePse(2,:),'^','linewidth',2,'Color',[72 143 49]/255, 'MarkerSize',5,...
   'MarkerEdgeColor',[72 143 49]/255,'MarkerFaceColor',[72 143 49]/255);

hold on;

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')




load('./bootlogCon.mat')



sizmPse=size(sub2);
a=mean(bootlog.pse(:,:,:,:),3);
log_m=mean(a(:,:,:,sub2),4);
log_se=std(a(:,:,:,sub2),0,4)/sqrt(sizmPse(2));



x=[1 2 4 8 16 32];

subplot(1,2,1);



plt.m=log_m(:,1);
plt.se=log_se(:,1);
plt.color=[222 66 91]/255;
plt.xrange=[0 35];
plt.yrange=[0.4 2];
plt.x=x;
d_plotpic2(plt);

hold on;

data=xlsread('post05.xlsx');
mPse(1,:)=mean(data(sub,:),1)';

sizdat=size(data(sub,:));
sePse(1,:)=std(data(sub,:),0,1)/sqrt(sizdat(1));

errorbar(x,mPse(1,:),sePse(1,:),'o','linewidth',2,'Color',[222 66 91]/255, 'MarkerSize',5,...
   'MarkerEdgeColor',[222 66 91]/255,'MarkerFaceColor',[222 66 91]/255);
hold on;

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')
%=================================
%=================================

subplot(1,2,2);




plt.m=log_m(:,2);
plt.se=log_se(:,2);
plt.color=[222 66 91]/255;
plt.xrange=[0 35];
plt.yrange=[0.9 3];
plt.x=x;
d_plotpic2(plt);

hold on;
clear data2
data2=xlsread('post10.xlsx');
mPse(2,:)=mean(data2(sub,:),1)';

sizdat=size(data2(sub,:));
sePse(2,:)=std(data2(sub,:),0,1)/sqrt(sizdat(1));

errorbar(x,mPse(2,:),sePse(2,:),'o','linewidth',2,'Color',[222 66 91]/255, 'MarkerSize',5,...
   'MarkerEdgeColor',[222 66 91]/255,'MarkerFaceColor',[222 66 91]/255);

hold on;

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')



function d_plotpic(plt);
m=plt.m;
se=plt.se;
color=plt.color;
xrange=plt.xrange;
yrange=plt.yrange;
x=plt.x

y1=m-se;
y2=m+se;


[xx,yy]=fill2line(x,y1,y2);
h=fill(xx,yy,color,'EdgeColor',color,'FaceAlpha',0.3,'EdgeAlpha',0.3);
set(h,'edgecolor','white');
set(gca, 'ylim',yrange);      %[0.7, 1.0000001]
set(gca, 'xlim',xrange);            %[0, 24]

hold on;

plot(x,m,'-',...
                'LineWidth',1,...
                'Color',color)
            hold on;
hold on;

function d_plotpic2(plt);
m=plt.m;
se=plt.se;
color=plt.color;
xrange=plt.xrange;
yrange=plt.yrange;
x=plt.x

y1=m-se;
y2=m+se;


[xx,yy]=fill2line(x,y1,y2);
h=fill(xx,yy,color,'EdgeColor',color,'FaceAlpha',0.3,'EdgeAlpha',0.3);
set(h,'edgecolor','white');
set(gca, 'ylim',yrange);      %[0.7, 1.0000001]
set(gca, 'xlim',xrange);            %[0, 24]

hold on;

plot(x,m,'-',...
                'LineWidth',2,...
                'Color',color)
            hold on;
hold on;

            
function [xx,yy]=fill2line(x,y1,y2)


sizX=size(x);
xx(1:sizX(2))=x;
xx(sizX(2)+1:sizX(2)*2)=x(1,sizX(2):-1:1);

yy(1:sizX(2))=y1';
yy(sizX(2)+1:sizX(2)*2)=y2(sizX(2):-1:1,1);
            