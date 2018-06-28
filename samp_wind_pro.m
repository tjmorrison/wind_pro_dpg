%Load and plot wind profiler data provided by DPG
%Written on   17-5-2018
%Travis Morrison & Fabien
%University of Utah
%Dept. of Mechanical Engineering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;

%Load wind data
%Change dta path for your personal computer
folder_path = 'C:\Users\tjmor\OneDrive\Research\Data\DPG_samp_wind\SLTest924\ASD\';
avg_time = '05'; %options are 05-five min avg, 10-ten min avg, 60-one-hour avg 
array = ["00","05"];
num_files = 2;
for ii  = 1:num_files
    data_path = strcat(folder_path,'w2018-05-10-10-',array(ii),'_',avg_time,'.asd');
    fID=fopen(data_path,'r');
    data2read=textscan(fID,'%s',1000,'delimiter','\n');
    data2read=data2read{1};
    fclose(fID);
    
    numLineHeader=9;
    
    tmp=str2num(data2read{7});
    numData1=tmp(1);
    
    header=textscan(data2read{9},'%s\t');
    header=header{1};
    numData2=numel(header);
    
    data=zeros(numData1,numData2);
    for kk=1:numData1
        data(kk,:,ii)=str2num(data2read{numLineHeader+kk});
    end
end
%change unavaible data to nans.
data(data == 999.9) = nan;



%Build structure based on data header for UX, need to check units from
%Dragan
wind_pro.z = squeeze(data(:,1,:)); %height
wind_pro.spd = squeeze(data(:,2,:)); %speed
wind_pro.dir = squeeze(data(:,3,:)); %Direction (deg)
wind_pro.QC = squeeze(data(:,4,:)); %Quality Control (0-1, 1 being the best)
wind_pro.u = squeeze(data(:,5,:)); %
wind_pro.v = squeeze(data(:,6,:));
wind_pro.w = squeeze(data(:,7,:));

clear data;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set plot settings
ft_size = 25;
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(0,'defaultTextInterpreter','latex');
set(0,'DefaultAxesFontSize',ft_size);

% Examine wind profile
figure(1)
semilogy(wind_pro.spd,wind_pro.z,'k-o')
grid on





