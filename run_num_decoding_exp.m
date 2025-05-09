%% Scripts for running Numerosity Decoding experiment

% Orinigally from cpp_lab\visual_motion_locali zer
% (C) Copyright 2018 Mohamed Rezk
% (C) Copyright 2020 CPfP visual motion localizer developpers

% modified by Ying Yang
getOnlyPress = 1;

% Clear all the previous stuff
clc;
if ~ismac
    close all;  clear Screen;
end

% make sure we got access to all the required functions and inputs
initEnv();

% set and load all the parameters to run the experiment
cfg = numDecoding_setParameters;
cfg = userInputs(cfg);
cfg = createFilename(cfg);

% load the stimuli from inputs
load('inputs/stimuli_numerositystimuli.mat');

%%  Experiment
% Safety loop: close the screen if code crashes
try

    %% Init the experiment
    %[cfg] = loadinputFiles(cfg); 
    % creates window and launches, with all the parameters
    cfg = initPTB(cfg);

    % creates design of experiment 
    cfg = numerosity_expDesign(cfg);

    % Prepare for the output logfiles with all
    logFile.extraColumns = cfg.extraColumns;
    logFile = saveEventsFile('init', cfg, logFile);
    logFile = saveEventsFile('open', cfg, logFile);

    % prepare the KbQueue to collect responses
    getResponse('init', cfg.keyboard.responseBox, cfg);

    standByScreen(cfg)

    % Wait for Trigger from Scanner
    waitForTrigger(cfg);

    %% Experiment Start

    % Fixation cross and get starting time
    cfg = getExperimentStart(cfg);

    getResponse('start', cfg.keyboard.responseBox);

    waitFor(cfg, cfg.timing.onsetDelay);

    %% Actual presentation of stimuli

    fprintf('\n Running Run %.0f - %s\n', string(cfg.subject.runNb)); 
    for iBlock = 1:cfg.design.nbBlocks

        if iBlock == 1
            waitFor(cfg, cfg.timing.firstfixation);
        end

        previousEvent.target = 0;

        % For each event in the "block" 
        for iEvent = 1:cfg.design.lengthBlock

            % Check for experiment abortion from operator
            checkAbort(cfg, cfg.keyboard.keyboard);

            [thisEvent, thisFixation, cfg] = preTrialSetup(cfg, iBlock, iEvent);

            % Get the path of the specific .png image 
            % string(cfg.design.names(iBlock))
            currentStimIndex = cfg.design.presMatrix(iBlock,iEvent);
            currentStimType = cfg.design.typeMatrix(iBlock,iEvent);

            if currentStimIndex < 5 %visual_sim stimuli
                
                countInd = string(cfg.design.vis_sim_count(currentStimType, currentStimIndex));

            eval(['thisImage = imageData.N' char(string(currentStimIndex)) '.T' char(string(currentStimType)) char(countInd) ';']);

            if cfg.design.targetMatrix(iBlock,iEvent) == 0
            cfg.design.vis_sim_count(currentStimType, currentStimIndex) = cfg.design.vis_sim_count(currentStimType, currentStimIndex)+1;
            end

            [onset, duration] = showDots(cfg, thisEvent, thisFixation, thisImage);
            else
                 if 4 < currentStimIndex && currentStimIndex < 9 %visual seq stimuli

                    currentcountInd = cfg.design.vis_seq_count(currentStimType, currentStimIndex-4);
                    eval(['dotsInfo = visSeqData.N' char(string(currentStimIndex-4)) '.T' char(string(currentStimType))  '(' char(string(currentcountInd)) ',:);']);
                    [onset, duration] = showseqdots(cfg, thisFixation, currentStimIndex, dotsInfo);

                    if cfg.design.targetMatrix(iBlock,iEvent) == 0
                        cfg.design.vis_seq_count(currentStimType, currentStimIndex-4)=cfg.design.vis_seq_count(currentStimType, currentStimIndex-4)+1;
                    end

                else
                    if 8 < currentStimIndex && currentStimIndex < 13 %auditory sequential 

                       currentcountInd = cfg.design.aud_seq_count(currentStimType, currentStimIndex-8);
%                      eval(['thisSound = soundData.N' char(string(currentStimIndex-8)) '.T' char(string(currentStimType)) ';']);
                       eval(['thisSound = soundData.B' char(string(currentStimIndex-8)) '.T' char(string(currentStimType)) char(string(currentcountInd)) ';']);
%                            stimfile = strcat(cfg.design.beepspath,'N',num2str(currentStimIndex-7),'T',num2str(currentStimType),'_',num2str(currentcountInd),'.wav');
%                            thisSound=audioread(char(stimfile))';

                           [onset, duration] = playSounds(cfg, thisEvent, thisSound, thisFixation);

                         if cfg.design.targetMatrix(iBlock,iEvent) == 0
                            cfg.design.aud_seq_count(currentStimType, currentStimIndex-8)=cfg.design.aud_seq_count(currentStimType, currentStimIndex-8)+1;
                         end

                    else
                        if 12 < currentStimIndex && currentStimIndex < 17 %arabic

                            [onset, duration] = showarabic(cfg, thisEvent, thisFixation, currentStimIndex);

                        else
                            if 16 < currentStimIndex && currentStimIndex < 21  

                               eval(['thisSound = soundData.A' char(string(currentStimIndex-16)) '.T' char(string(currentStimType)) ';']);
                               [onset, duration] = playSounds(cfg, thisEvent, thisSound, thisFixation);
                            end
                        end
                    end
                end
            end

            imgToSave = char(eventNames{currentStimIndex,currentStimType});

            thisEvent = preSaveSetup(thisEvent, iBlock, iEvent, ...
                                     duration, onset, cfg, imgToSave, logFile);

            saveEventsFile('save', cfg, thisEvent);

            waitFor(cfg, cfg.design.isiMatrix(iBlock,iEvent));

            responseEvents = getResponse('check', cfg.keyboard.responseBox, cfg, getOnlyPress);

            triggerString = ['trigger_' cfg.design.blockNames{iBlock}];
            saveResponsesAndTriggers(responseEvents, cfg, logFile, triggerString);

            previousEvent = thisEvent;

        end

        drawFixation(cfg);
        Screen('Flip',cfg.screen.win);

        if iBlock < cfg.design.nbBlocks
            nextBlock = iBlock + 1;
            waitFor(cfg,cfg.timing.IBI)
        else
            nextBlock = cfg.design.nbBlocks;
        end

        % trigger monitoring
        triggerEvents = getResponse('check', cfg.keyboard.responseBox, cfg, ...
                                    getOnlyPress);

        triggerString = 'trigger_baseline';
        saveResponsesAndTriggers(triggerEvents, cfg, logFile, triggerString);

    end

    % End of the run for the BOLD to go down
    waitFor(cfg, cfg.timing.endDelay);

    cfg = getExperimentEnd(cfg);
    % Close the logfiles
    saveEventsFile('close', cfg, logFile);

    getResponse('stop', cfg.keyboard.responseBox);
    getResponse('release', cfg.keyboard.responseBox);

    createJson(cfg, cfg);

    cleanUp();

catch

    cleanUp();
    psychrethrow(psychlasterror);

end