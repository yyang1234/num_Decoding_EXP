% (C) Copyright 2020 CPP visual motion localizer developpers

function varargout = preSaveSetup(varargin)
    % varargout = postInitializatinSetup(varargin)

    % generic function to prepare structures before saving

    [thisEvent, iBlock, iEvent, duration, onset, cfg, stim_name, logFile] = ...
        deal(varargin{:});

    thisEvent.event = iEvent;
    thisEvent.block = iBlock;
    thisEvent.keyName = 'n/a';
    thisEvent.duration = duration;
    thisEvent.onset = onset - cfg.experimentStart;
    thisEvent.stim_name = stim_name;
    
    % Save the events txt logfile
    % we save event by event so we clear this variable every loop
    thisEvent.isStim = logFile.isStim;
    thisEvent.fileID = logFile.fileID;
    thisEvent.extraColumns = logFile.extraColumns;

    varargout = {thisEvent};

end
