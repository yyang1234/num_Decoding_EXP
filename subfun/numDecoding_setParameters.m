% (C) Copyright 2020 CPP visual motion localizer developpers

function [cfg] = numDecoding_setParameters()

    % VISUAL LOCALIZER

    % Initialize the parameters and general configuration variables
    cfg = struct();

    % by default the data will be stored in an output folder created where the
    % setParamters.m file is
    % change that if you want the data to be saved somewhere else
    cfg.dir.output = fullfile(fileparts(mfilename('fullpath')), 'output');

    %% Debug mode settings

    cfg.debug.do = false; % To test the script out of the scanner, skip PTB sync
    cfg.debug.smallWin = false; % To test on a part of the screen, change to 1
    cfg.debug.transpWin = false; % To test with trasparent full size screen
    cfg.debug.showMouse = true;

    cfg.skipSyncTests = 1;

    cfg.verbose = 1;

    %% Engine parameters

    cfg.testingDevice = 'mri';
    cfg.eyeTracker.do = false;
    cfg.audio.do = true;

    cfg.audio.inputChannels = 1;

    cfg = setMonitor(cfg);

    % Keyboards
    cfg = setKeyboards(cfg);

    % MRI settings
    cfg = setMRI(cfg);
%     cfg.suffix.acquisition = '0p75mmEvTr2p18'; % Is it changeable? 
    cfg.suffix.acquisition = '0p75mmEv';
    cfg.audio.channels = 1;             
    cfg.pacedByTriggers.do = false;

    %% Experiment Design

    cfg.design.localizer = 'VWFA';

    cfg.design.names = {'numerosity'};

    cfg.design.nbRepetitions = 2;
    cfg.design.nbEventsPerBlock = 20;
    cfg.design.vis_sim_count = [1,1,1,1;1,1,1,1];
    cfg.design.vis_seq_count = [1,1,1,1;1,1,1,1];
    cfg.design.aud_seq_count = [1,1,1,1;1,1,1,1];
%     cfg.design.beepspath = '/Users/yiyang/Dropbox/numMVPA/expsounds/';

    %% Timing
%     cfg.timing.eventDuration = 2 - (1/60)*15; % second
    cfg.timing.eventDuration = 1.25;
    % Time between blocs in secs
    cfg.timing.IBI = 15;
    % Time between events in secs
    cfg.timing.ISI = [3.5 4 4.5];
    cfg.timing.firstfixation = 4;
    % Number of seconds before the motion stimuli are presented
    cfg.timing.onsetDelay = 0;
    % Number of seconds after the end all the stimuli before ending the run
    cfg.timing.endDelay = 3.6;
    %type 1:
    cfg.timing.energy = 1.32;
    cfg.timing.ttpause = 0.68;
    cfg.timing.desired_duration = [0.2,0.15];
    cfg.timing.dotsISI = 0.125;
    cfg.timing.sumdur = 1600;
    cfg.timing.min = 100;
    cfg.timing.max = 1000;
    cfg.timing.type1MinDur =[0.127,0.178,0.27,0.48];
    %for visual number
    cfg.onset = [];
    cfg.offset = [];
    cfg.timing.arabicDuration = 1;
    cfg.task.arabicfontSize = [90,110,130,150];
    cfg.task.arabicLocationA = -50;
    cfg.task.arabicLocationB = 50;
    %% Task(s)
    cfg.task.name = 'numMVPA';

    % Instruction
    cfg.task.instruction = 'Detect the repeated numerosity regardless of format and modality';
    % Fixation cross (in pixels)
    cfg.fixation.type = 'cross';
    cfg.fixation.color = cfg.color.green;
    cfg.fixation.width = .3;
    cfg.fixation.lineWidthPix = 2;
    
    cfg.fixation.xDisplacement = 0;
    cfg.fixation.yDisplacement = 0;

    % target (referring to the words)
    cfg.target.maxNbPerBlock = 3; % 10% of 20 is 2
    cfg.target.duration = 0.1; % In secs
    cfg.target.type = 'repetition';

    % for seq dots
    cfg.dots.SizePix = 60;
    cfg.dots.color = cfg.color.white;

    cfg.extraColumns = {'stim_name', 'target', 'event', 'block', 'keyName'};    

end

function cfg = setKeyboards(cfg)
    cfg.keyboard.escapeKey = 'ESCAPE';
    cfg.keyboard.responseKey = {'a' 'b' 'c' 'd'};
    cfg.keyboard.keyboard = [];
    cfg.keyboard.responseBox = [];

    if strcmpi(cfg.testingDevice, 'mri')
        cfg.keyboard.keyboard = [];
        cfg.keyboard.responseBox = [];
    end
end

function cfg = setMRI(cfg)
    % letter sent by the trigger to sync stimulation and volume acquisition
    cfg.mri.triggerKey = 's';
    cfg.mri.triggerNb = 1;

    cfg.mri.repetitionTime = 1.75;

    cfg.bids.MRI.Instructions = 'Detect the repeated stimulus';
    cfg.bids.MRI.TaskDescription = [];
    cfg.bids.mri.SliceTiming = [
        0,0.875,0.0673077,0.942308,0.134615,1.00962,0.201923,1.07692,0.269231,1.14423,...
        0.336538,1.21154,0.403846,1.27885,0.471154,1.34615,0.538462,1.41346,...
        0.605769,1.48077,0.673077,1.54808,0.740385,1.68269,0.807692,1.61538,...
        0,0.875,0.0673077,0.942308,0.134615,1.00962,0.201923,1.07692,...
        0.269231,1.14423,0.336538,1.21154,0.403846,1.27885,0.471154,...
        1.34615,0.538462,1.41346,0.605769,1.48077,0.673077,1.54808,...
        0.740385,1.68269,0.807692,1.61538];    

end

function cfg = setMonitor(cfg)

    % Monitor parameters for PTB
    cfg.color.white = [255 255 255];
    cfg.color.black = [0 0 0];
    cfg.color.red = [255 0 0];
    cfg.color.green = [0 255 0];
    cfg.color.grey = mean([cfg.color.black; cfg.color.white]);
    cfg.color.background = cfg.color.black;
    cfg.text.color = cfg.color.white;

    % Monitor parameters
    cfg.screen.monitorWidth = 50; % in cm
    cfg.screen.monitorDistance = 40; % distance from the screen in cm

    if strcmpi(cfg.testingDevice, 'mri')
%         cfg.screen.monitorWidth = 25;
%         cfg.screen.monitorDistance = 95;
    cfg.screen.monitorWidth = 69.8;
    cfg.screen.monitorDistance = 170;
    end

end

