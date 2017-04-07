%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Inclinometer Data Analysis%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; format long g; clc; close all

%% Loading Data
A=load('170322_Nivel 2.out');
B= A(199:9977,:);
x = B(:,4);                         % inclination on x-axis
y = B(:,5);                         % inclination on y-axis 
Temp = B(:,6);                      % Tempurature
T = [10 34 5.2;11 02 54.4];
T_GPS = T(:,1)*3600 + T(:,2)*60 + T(:,3);
%% define the Time
h= B(:,1);                          % hours
m= B(:,2);                          % Minutes
s= B(:,3);                          % Seconds
time = (h*3600)+(m*60)+s;           % Conversion to seconds
for i=1:9779;
    t(i,1) = time(i,1)-time(1,1);   % Time from inclinometer
end
disX=1000*tan(x/1000);              % Inclination in the the longitudinal axis
disY=1000*tan(y/1000);              % Inclination in the the longitudinal axis
%scatter(y_filter,x_filter);
% figure; plot(t,disX,'b')
% figure; plot(t,disY,'r')

%% Trails' time

C=load('Trails.txt');
hh= C(:,1);                         % hours
mm= C(:,2);                         % Minutes
ss= C(:,3);                         % Seconds
time_t = (hh*3600)+(mm*60)+ss;      % Conversion to seconds 
[r,c]=size(time_t);              
for i=1:(r/2);
    tt(i,1) = time_t(2*i,1)-time_t(2*i-1,1);   % Time of each trail
end
trail_time = time_t(2:end-1,1) - time_t(1,1);              % Time from GPS

%% Filtering the timeseries in X_axis

mean_samp_rate = 5;

x_filter = filter_2sides_highpass(disX);
figure,
f2=plot(t,x_filter,'r');
title('High pass Filter - Longitudinal Axis')
ylabel('High-Frequency(m)'); xlabel('Time(s)'); legend('Displacement after filtering');
saveas(f2,'Figure 2','jpg');

%% Filtering the timeseries in Y_axis

%ALINA WAS HERE -__________________________-

y_filter = filter_2sides_highpass(disY);
figure();
plot(t,y_filter,'r');
hold on;plot(t,x_filter,'b');
title('High pass Filter - Lateral Axis')
ylabel('High-Frequency(m)'); xlabel('Time(s)'); legend('Displacement after filtering');
%saveas(f2,'Figure 2','jpg');
hold off
 %% add events

timeAdjustmentFromVisual = 0;
eventsTimes = [517 578 578 635 675 0 826 879 965 1000 1063 1114 1200 1241 1345 1386 1485 1523]-timeAdjustmentFromVisual;

figure,plot(t,x_filter,'b');hold
for idx = 1 : numel(eventsTimes)
    plot([eventsTimes(idx) eventsTimes(idx)], [-2 4],'g','LineWidth',3);
end

hold off
figure,plot(t,y_filter,'r');
hold on;plot(t,x_filter,'b');
plot(t,y_filter,'r');hold
for idx = 1 : numel(eventsTimes)
    plot([eventsTimes(idx) eventsTimes(idx)], [-2 4],'g','LineWidth',3);
end

timeAdjustmentForSixtineTime = -3;
eventsTimes = trail_time-timeAdjustmentForSixtineTime;
for idx = 1 : numel(eventsTimes)
    plot([eventsTimes(idx) eventsTimes(idx)], [-2 4],'c--','LineWidth',3);
end

% end of Alina code
  

%% Cropping the 1st Excitation
row1 = find(t>=trail_time(1,1) & t<=trail_time(2,1));
size_row1 = size(row1);
time_crop1 = t(row1(1,1):row1(size_row1(1,1)));
x_crop1 = x_filter(row1(1,1):row1(size_row1(1,1)));
y_crop1 = y_filter(row1(1,1):row1(size_row1(1,1)));

% figure, plot(time_crop1,x_crop1,'b');
% hold on
% plot(time_crop1,y_crop1,'r');
% title('Bridge Deformation - Cropping The Excitation')
% ylabel('High-Frequency(m)'); xlabel('Time (s)'); legend('Longitudinal','Lateral','Location', 'best');
% saveas(f3,'Figure 3','jpg');

%% Cropping the 2nd Excitation
row2 = find(t>=trail_time(3,1) & t<=trail_time(4,1));
size_row2 = size(row2);
time_crop2 = t(row2(1,1):row2(size_row2(1,1)));
x_crop2 = x_filter(row2(1,1):row2(size_row2(1,1)));
y_crop2 = y_filter(row2(1,1):row2(size_row2(1,1)));

%% Cropping the 3rd Excitation
row3 = find(t>=trail_time(5,1) & t<=trail_time(6,1));
size_row3 = size(row3);
time_crop3 = t(row3(1,1):row3(size_row3(1,1)));
x_crop3 = x_filter(row3(1,1):row3(size_row3(1,1)));
y_crop3 = y_filter(row3(1,1):row3(size_row3(1,1)));

%% Cropping the 4th Excitation
row4 = find(t>=trail_time(7,1) & t<=trail_time(8,1));
size_row4 = size(row4);
time_crop4 = t(row4(1,1):row4(size_row4(1,1)));
x_crop4 = x_filter(row4(1,1):row4(size_row4(1,1)));
y_crop4 = y_filter(row4(1,1):row4(size_row4(1,1)));

%% Cropping the 5th Excitation
row5 = find(t>=trail_time(9,1) & t<=trail_time(10,1));
size_row5 = size(row5);
time_crop5 = t(row5(1,1):row5(size_row5(1,1)));
x_crop5 = x_filter(row5(1,1):row5(size_row5(1,1)));
y_crop5 = y_filter(row5(1,1):row5(size_row5(1,1)));

%% Cropping the 6th Excitation
row6 = find(t>=trail_time(11,1) & t<=trail_time(12,1));
size_row6 = size(row6);
time_crop6 = t(row6(1,1):row6(size_row6(1,1)));
x_crop6 = x_filter(row6(1,1):row6(size_row6(1,1)));
y_crop6 = y_filter(row6(1,1):row6(size_row6(1,1)));

%% Cropping the 7th Excitation
row7 = find(t>=trail_time(13,1) & t<=trail_time(14,1));
size_row7 = size(row7);
time_crop7 = t(row7(1,1):row7(size_row7(1,1)));
x_crop7 = x_filter(row7(1,1):row7(size_row7(1,1)));
y_crop7 = y_filter(row7(1,1):row7(size_row7(1,1)));

%% Cropping the 8th Excitation
row8 = find(t>=trail_time(15,1) & t<=trail_time(16,1));
size_row8 = size(row8);
time_crop8 = t(row8(1,1):row8(size_row8(1,1)));
x_crop8 = x_filter(row8(1,1):row8(size_row8(1,1)));
y_crop8 = y_filter(row8(1,1):row8(size_row8(1,1)));

%% Cropping the 9th Excitation
row9 = find(t>=trail_time(17,1) & t<=trail_time(18,1));
size_row9 = size(row9);
time_crop9 = t(row9(1,1):row9(size_row9(1,1)));
x_crop9 = x_filter(row9(1,1):row9(size_row9(1,1)));
y_crop9 = y_filter(row9(1,1):row9(size_row9(1,1)));

Sizes = [0 0;size(x_crop1);size(x_crop2);size(x_crop3);size(x_crop4);size(x_crop5);size(x_crop6);size(x_crop7);size(x_crop8);size(x_crop9)];

%% Plotting Excitation periods

x_crop_total =[x_crop1 x_crop2 x_crop3 x_crop4 x_crop5 x_crop6 x_crop7 x_crop8 x_crop9];
y_crop_total =[y_crop1 y_crop2 y_crop3 y_crop4 y_crop5 y_crop6 y_crop7 y_crop8 y_crop9];
t_crop_total =[time_crop1;time_crop2;time_crop3;time_crop4;time_crop5;time_crop6;time_crop7;time_crop8;time_crop9];
Colors = ['g','g','g','r','r','r','b','g','r'];
Titles = ['1st Excitation';'2nd Excitation';'3rd Excitation';'4th Excitation';...
    '5th Excitation';'6th Excitation';'7th Excitation';'8th Excitation';'9th Excitation'];

for j = 1:9;
    Start(j,1)= sum(Sizes(1:j,2))+1;
    End(j,1) = Start(j,1)-1+Sizes(j+1,2);
%     figure, 
%     plot(t_crop_total(Start(j):End(j)),x_crop_total(Start(j,1):End(j,1)),'b')
%     title(Titles(j,1:14))
%     xlabel('Time (s)'); ylabel('inclination (m)')
%     hold on
%     plot(t_crop_total(Start(j):End(j)),y_crop_total(Start(j,1):End(j,1)),'r')
    
    %% 3-Sigma zone

    Avrg_x(Start(j,1):End(j,1)) = mean(x_crop_total(Start(j,1):End(j,1)));
    Avrg_y(Start(j,1):End(j,1)) = mean(y_crop_total(Start(j,1):End(j,1)));
    sigma_x(j,1) = std(x_crop_total(Start(j,1):End(j,1)));
    sigma_y(j,1) = std(y_crop_total(Start(j,1):End(j,1)));
    Amp_x(Start(j,1):End(j,1)) = abs((Avrg_x(Start(j,1):End(j,1))+3*sigma_x(j,1))-...
        (Avrg_x(Start(j,1):End(j,1))-3*sigma_x(j,1)));
    Amp_y(Start(j,1):End(j,1)) = abs((Avrg_y(Start(j,1):End(j,1))+3*sigma_y(j,1))-...
        (Avrg_y(Start(j,1):End(j,1))-3*sigma_y(j,1)));
    
    %% Plotting
    figure,
    plot(t_crop_total(Start(j):End(j)),x_crop_total(Start(j,1):End(j,1)),'b')
    title(Titles(j,1:14))
    xlabel('Time (s)'); ylabel('inclination (m)')
    hold on
    plot(t_crop_total(Start(j):End(j)),y_crop_total(Start(j,1):End(j,1)),'r')
    % Plotting the mean
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1)),'m')
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1)),'k')
    % Plotting the Confidence interval on X-axis
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1))+3*sigma_x(j),'g')
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1))+3*sigma_y(j),'c')
    % Plotting the Confidence interval on Y-axis
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1))-3*sigma_x(j),'g')
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1))-3*sigma_y(j),'c')
   
    legend('Longitudinal','Lateral','Mean_X','Mean_Y','99% confidence interval_X',...
       '99% confidence interval_Y','location','best')
  
end
%%  Spectral Analysis
for n = 1:9;
%     dt(Start(n):End(n)) = mean(diff(t_crop_total(Start(n):End(n))));
%     nbr_freq(Start(n):End(n)) = size(t_crop_total(Start(n):End(n)),1)/2;
%     [freq(Start(n):End(n)),Ampli(Start(n):End(n)),Phase(Start(n):End(n)),...
%         a(Start(n):End(n)),b(Start(n):End(n))] = DFT(t_crop_total(Start(n):End(n)),...
%     x_crop_total(Start(n,1):End(n,1)),dt(Start(n):End(n)),nbr_freq(Start(n):End(n)),0);

end
    
%% Time Difference
% figure
% plot(t,'o')
% figure,
% hist(x_filter);
% figure,
% hist(y_filter);
% figure,
% plot(t,x_filter,'g')
% hold on 
% plot(t, y_filter, 'r')
% figure,
% hist(hist(t,unique(t)))

