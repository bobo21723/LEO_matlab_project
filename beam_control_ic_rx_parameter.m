% clear
integer_delay = 0;
integer_delay_sample_freq = 3.25e10;
integer_delay_mux_input = 1;
fraction_delay = 1;
%fraction_delay = 1;
%fraction_delay = 2;
RX_sample_freq = 1e7;
y = linspace(-1,1,10);

rx_amplitude_compensation = 1;
rx_freq_d_compensation = 250e6;
rx_phase_compensation = 0;
Ref = 2.048;
N = 10;
Bias = 0;

% x = randn(20000,1);
% fs=6.75e10;
% rx_bp_filter = bandpass(x,[3.125e9 3.375e9],fs);
% realizemdl(rx_bp_filter);
sw = 0;% 0:Cubic Lagrange 1:Cubic B-spline
switch sw
    case 0
        filter_gain0_0 = 0;
        filter_gain0_1 = 0;
        filter_gain0_2 = 1;
        filter_gain0_3 = 0; 
        filter_gain1_0 = -1/6;
        filter_gain1_1 = 1;
        filter_gain1_2 = -0.5;
        filter_gain1_3 = -1/3;
        filter_gain2_0 = 0;
        filter_gain2_1 = 0.5;
        filter_gain2_2 = -1;
        filter_gain2_3 = 0.5;
        filter_gain3_0 = 1/6;
        filter_gain3_1 = -0.5;
        filter_gain3_2 = 0.5;
        filter_gain3_3 = -1/6;
    case 1
        filter_gain0_0 = 0;
        filter_gain0_1 = 1/6;
        filter_gain0_2 = 2/3;
        filter_gain0_3 = 1/6;
        filter_gain1_0 = 0;
        filter_gain1_1 = 1/2;
        filter_gain1_2 = 0;
        filter_gain1_3 = -1/2;
        filter_gain2_0 = 0;
        filter_gain2_1 = 1/2;
        filter_gain2_2 = -1;
        filter_gain2_3 = 1/2;
        filter_gain3_0 = 1/6;
        filter_gain3_1 = -1/2;
        filter_gain3_2 = 1/2;
        filter_gain3_3 = -1/6;
end

%generate cic decimetion filter & realize to simulink
%hm=mfilt.cicdecim(2,1,2);
%realizemdl(hm);



%Generate Fraction delay filter  & Synthesis rtl code,testbench
% fDelay = 0.3;
% filtdes = fdesign.fracdelay(fDelay, 'N', 3);
% Hd = design(filtdes,'lagrange', 'FilterStructure', 'farrowfd');
% % info(Hd)
% Hd.arithmetic            = 'fixed';
% Hd.InputWordLength       = 8;
% Hd.InputFracLength       = 6;
% Hd.CoeffWordLength       = 8;
% Hd.FDWordLength          = 6;
% Hd.FDAutoScale           = false;
% Hd.FDFracLength          = 6;
% % workingdir = 'C:\ITRI\project\LEO\matlab\beam_control_rx_1206';
% workingdir = pwd;
% generatehdl(Hd, 'Name', 'hdlfarrow', ...  
%                 'TargetLanguage', 'Verilog',...
%                 'TargetDirectory', workingdir);
% t=-2:0.01:2;                           % +/-2 secs @ 100 Hz sample rate
% userinputstim = chirp(t,100,1,200,'q'); % Start @100Hz, cross 200Hz at t=1sec 
% leninput = length(userinputstim);
% samplefdvalues = [0.1, 0.34, 0.78, 0.56, 0.93, 0.25, 0.68, 0.45];
% samplesheld = ceil(leninput/length(samplefdvalues));
% ix = 1;
% for n = 1:length(samplefdvalues)-1
%     userfdstim(ix: ix + samplesheld-1) =  repmat(samplefdvalues(n),1, samplesheld);
%     ix = ix + samplesheld;
% end
% userfdstim(ix:leninput)= repmat(samplefdvalues(end),1 , leninput-length(userfdstim));
% 
% generatehdl(Hd, 'Name', 'hdlfarrow', ...
%     'GenerateHDLTestbench', 'on', ...
%     'TestBenchName', 'hdlfarrow_userdefined_tb',...
%     'TargetLanguage', 'Verilog',...
%     'TestBenchUserStimulus', userinputstim,...
%     'TestbenchFracDelaystimulus', userfdstim, ...
%     'TargetDirectory', workingdir);