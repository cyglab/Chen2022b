clear

load('./bootlog.mat')

% PSE predicted by model, length * time interval * subject
pse=squeeze(mean(bootlog.pse,3));

% sigma_m
para_m=squeeze(mean(bootlog.para,2));
para_sd=squeeze(std(bootlog.para,0,2));

ws_m=para_m(1,:)';
ws_se=para_sd(1,:)';

sigma_sm_m=para_m(2,:)';
sigma_sm_se=para_sd(2,:)';

% strongth of Kappa effect
w0=bootlog.para(1,:,:);
k_m=squeeze(mean(1-w0,2));
k_se=squeeze(std(1-w0,0,2));

sigma_sm0=bootlog.para(2,:,:);

sigma_t0=sqrt(w0./abs(1-w0)).*sigma_sm0;

sigma_st_m=squeeze(mean(sigma_t0,2));
sigma_st_se=squeeze(std(sigma_t0,0,2));

p_m(:,1)=ws_m;
p_m(:,2)=sigma_sm_m;
p_m(:,3)=k_m;
p_m(:,4)=sigma_st_m;

p_se(:,1)=ws_se;
p_se(:,2)=sigma_sm_se;
p_se(:,3)=k_se;
p_se(:,4)=sigma_st_se;


