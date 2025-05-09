function [cfg] = numerosity_expDesign(cfg, displayFigs)

%% Check inputs and distribute targets

% Set to 1 for a visualtion of the trials design order
if nargin < 2 || isempty(displayFigs)
    displayFigs = 0;
end

% Set variables here for a dummy test of this function
if nargin < 1 || isempty(cfg)
    error('give me something to work with');
end

[NB_BLOCKS, NB_REPETITIONS, NB_EVENTS_PER_BLOCK, MAX_TARGET_PER_BLOCK] = getDesignInput(cfg);
nbRun = cfg.subject.runNb;

%% load file with randomize events order
ranfileName = ['inputs/random_trial_sub' num2str(cfg.subject.subjectNb) '.mat'];
load(ranfileName);
tarfileName = ['inputs/target_mat_sub' num2str(cfg.subject.subjectNb) '.mat'];
load(tarfileName);
numTargetsForEachBlock = 2;
runind = 1:2:40;
shuffledEv = shuffledEv(runind(nbRun):runind(nbRun)+1,:);
repetitionTargets = repetitionTargetsMat(runind(nbRun):runind(nbRun)+1,:);
%% assign type index 
types1 = [1,1,2,2];
types2 = [2,2,1,1];
typesInd1 = [types1,types1,types1,types1,types1];
typesInd2 = [types2,types2,types2,types2,types2];
for t=1%size(shuffledEv,1)
    for te=1:size(shuffledEv,2)
        typeInd(t,te)=typesInd1(shuffledEv(t,te));
    end
end

for t=2%size(shuffledEv,1)
    for te=1:size(shuffledEv,2)
        typeInd(t,te)=typesInd2(shuffledEv(t,te));
    end
end

%% Create repetitions, nulls, targets
orderMatrix = zeros(NB_BLOCKS,NB_EVENTS_PER_BLOCK + MAX_TARGET_PER_BLOCK);  
targetMatrix = zeros(NB_BLOCKS,NB_EVENTS_PER_BLOCK + MAX_TARGET_PER_BLOCK); 
typeMatrix = zeros(NB_BLOCKS,NB_EVENTS_PER_BLOCK + MAX_TARGET_PER_BLOCK);

for k = 1:size(repetitionTargets,1)
    e = 1; % index to go through the new matrix. Will skip ahead when encountering a target

    for m = 1:size(repetitionTargets,2)
        
        if repetitionTargets(k,m) == 1
            orderMatrix(k,e) = shuffledEv(k,m);
             typeMatrix(k,e) = typeInd(k,m);
            e = e + 1;

                if shuffledEv(k,m) == 1 || shuffledEv(k,m) == 5 || shuffledEv(k,m) == 9 || shuffledEv(k,m) == 13 || shuffledEv(k,m) == 17
                     if shuffledEv(k,m+1) == 2 || shuffledEv(k,m+1) == 3 || shuffledEv(k,m+1) == 4 
                         repopt = setdiff([5,9,13,17], shuffledEv(k,m));
                         repindex = repopt(randi(length(repopt)));
                     else
                         if shuffledEv(k,m+1) == 6 || shuffledEv(k,m+1) == 7 || shuffledEv(k,m+1) == 8
                         repopt = setdiff([1,9,13,17], shuffledEv(k,m));
                         repindex = repopt(randi(length(repopt)));
                         else
                             if shuffledEv(k,m+1) == 10 || shuffledEv(k,m+1) == 11 || shuffledEv(k,m+1) == 12 
                             repopt = setdiff([1,5,13,17], shuffledEv(k,m));
                             repindex = repopt(randi(length(repopt)));
                             else
                                 if shuffledEv(k,m+1) == 14 || shuffledEv(k,m+1) == 15 || shuffledEv(k,m+1) == 16 
                                     repopt = setdiff([1,5,9,17], shuffledEv(k,m));
                                     repindex = repopt(randi(length(repopt)));
                                 else
                                     if shuffledEv(k,m+1) == 18 || shuffledEv(k,m+1) == 19 || shuffledEv(k,m+1) == 20 
                                     repopt = setdiff([1,5,9,13], shuffledEv(k,m));
                                     repindex = repopt(randi(length(repopt))); 
                                     end
                                 end
                             end
                         end
                     end
                     orderMatrix(k,e) = repindex;
                    typeMatrix(k,e) = typeInd(k,m);

                    else
                    if shuffledEv(k,m) == 2 || shuffledEv(k,m) == 6 || shuffledEv(k,m) == 10 || shuffledEv(k,m) == 14 || shuffledEv(k,m) == 18
                        if shuffledEv(k,m+1) == 1 || shuffledEv(k,m+1) == 3 || shuffledEv(k,m+1) == 4 
                         repopt = setdiff([6,10,14,18], shuffledEv(k,m));
                         repindex = repopt(randi(length(repopt)));
                         else
                             if shuffledEv(k,m+1) == 5 || shuffledEv(k,m+1) == 7 || shuffledEv(k,m+1) == 8 
                             repopt = setdiff([2,10,14,18], shuffledEv(k,m));
                             repindex = repopt(randi(length(repopt)));
                             else
                                 if shuffledEv(k,m+1) == 9 || shuffledEv(k,m+1) == 11 || shuffledEv(k,m+1) == 12 
                                 repopt = setdiff([2,6,14,18], shuffledEv(k,m));
                                 repindex = repopt(randi(length(repopt)));
                                 else
                                     if shuffledEv(k,m+1) == 13 || shuffledEv(k,m+1) == 15 || shuffledEv(k,m+1) == 16 
                                         repopt = setdiff([2,6,10,18], shuffledEv(k,m));
                                         repindex = repopt(randi(length(repopt)));
                                     else 
                                         if shuffledEv(k,m+1) == 17 || shuffledEv(k,m+1) == 19 || shuffledEv(k,m+1) == 20 
                                             repopt = setdiff([2,6,10,14], shuffledEv(k,m));
                                             repindex = repopt(randi(length(repopt)));
                                         end
                                     end
                                 end
                             end
                         end
                     orderMatrix(k,e) = repindex;
                    typeMatrix(k,e) = typeInd(k,m);

                    else
                        if shuffledEv(k,m) == 3 || shuffledEv(k,m) == 7 || shuffledEv(k,m) == 11 || shuffledEv(k,m) == 15 || shuffledEv(k,m) == 19
                     if shuffledEv(k,m+1) == 1 || shuffledEv(k,m+1) == 2 || shuffledEv(k,m+1) == 4 
                         repopt = setdiff([7,11,15,19], shuffledEv(k,m));
                         repindex = repopt(randi(length(repopt)));
                     else
                         if shuffledEv(k,m+1) == 5 || shuffledEv(k,m+1) == 6 || shuffledEv(k,m+1) == 8 
                             repopt = setdiff([3,11,15,19], shuffledEv(k,m));
                             repindex = repopt(randi(length(repopt)));
                         else
                             if shuffledEv(k,m+1) == 9 || shuffledEv(k,m+1) == 10 || shuffledEv(k,m+1) == 12 
                                 repopt = setdiff([3,7,15,19], shuffledEv(k,m));
                                 repindex = repopt(randi(length(repopt)));
                             else
                                 if shuffledEv(k,m+1) == 13 || shuffledEv(k,m+1) == 14 || shuffledEv(k,m+1) == 16 
                                     repopt = setdiff([3,7,11,19], shuffledEv(k,m));
                                     repindex = repopt(randi(length(repopt)));
                                 else
                                     if shuffledEv(k,m+1) == 17 || shuffledEv(k,m+1) == 18 || shuffledEv(k,m+1) == 20 
                                         repopt = setdiff([3,7,11,15], shuffledEv(k,m));
                                         repindex = repopt(randi(length(repopt)));
                                     end
                                 end
                             end
                         end
                     end
                     orderMatrix(k,e) = repindex;
                     typeMatrix(k,e) = typeInd(k,m);

                        else
                            if shuffledEv(k,m) == 4 || shuffledEv(k,m) == 8 || shuffledEv(k,m) == 12 || shuffledEv(k,m) == 16 || shuffledEv(k,m) == 20

                    if shuffledEv(k,m+1) == 1 || shuffledEv(k,m+1) == 2 || shuffledEv(k,m+1) == 3 
                         repopt = setdiff([8,12,16,20], shuffledEv(k,m));
                         repindex = repopt(randi(length(repopt)));
                     else
                         if shuffledEv(k,m+1) == 5 || shuffledEv(k,m+1) == 6 || shuffledEv(k,m+1) == 7 
                         repopt = setdiff([4,12,16,20], shuffledEv(k,m));
                         repindex = repopt(randi(length(repopt)));
                         else
                             if shuffledEv(k,m+1) == 9 || shuffledEv(k,m+1) == 10 || shuffledEv(k,m+1) == 11 
                             repopt = setdiff([4,8,16,20], shuffledEv(k,m));
                             repindex = repopt(randi(length(repopt)));
                             else
                                 if shuffledEv(k,m+1) == 13 || shuffledEv(k,m+1) == 14 || shuffledEv(k,m+1) == 15 
                                     repopt = setdiff([4,8,12,20], shuffledEv(k,m));
                                     repindex = repopt(randi(length(repopt)));
                                 else
                                     if shuffledEv(k,m+1) == 17 || shuffledEv(k,m+1) == 18 || shuffledEv(k,m+1) == 19 
                                         repopt = setdiff([4,8,12,16], shuffledEv(k,m));
                                         repindex = repopt(randi(length(repopt)));
                                     end
                                 
                                 end
                             end
                         end
                     end
                     orderMatrix(k,e) = repindex;
                      typeMatrix(k,e) = typeInd(k,m);
                            end
                        end
                     end
                end
            
            targetMatrix(k,e) = 1;
            e = e + 1;

        else % neither
            orderMatrix(k,e) = shuffledEv(k,m);
             typeMatrix(k,e) = typeInd(k,m);
            e = e + 1;
        end
    end
end

%% Create ISI matrix with variations
% 
isi = cfg.timing.ISI;
sizes = size(orderMatrix);                  
totLength = round((sizes(1) * sizes(2))/length(isi));
isiArray = repmat(isi, 1, totLength);
isiArray = [isiArray,4];
isiArray = shuffle(isiArray);              
isiArray = isiArray(1:((sizes(1) * sizes(2))));
isiMatrix = reshape(isiArray,[sizes(1), sizes(2)]);

%% Now we do the easy stuff
cfg.design.blockNames = assignConditions(cfg);
cfg.design.nbBlocks = NB_BLOCKS;
cfg.design.repetitionTargets = repetitionTargets;

cfg.design.lengthBlock = numTargetsForEachBlock + NB_EVENTS_PER_BLOCK; 
cfg.design.presMatrix = orderMatrix;
cfg.design.targetMatrix = targetMatrix;
cfg.design.isiMatrix = isiMatrix;
cfg.design.typeMatrix = typeMatrix;

end
