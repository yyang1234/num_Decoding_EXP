function [conditionNamesVector, CON1_INDEX, CON2_INDEX] = assignConditions(cfg)

    [~, nbRepet] = getDesignInput(cfg);

    conditionNamesVector = repmat(cfg.design.names, nbRepet, 1);

    % Get the index of each condition
    nameCondition1 = 'arithmetic';
    nameCondition2 = 'language';


    CON1_INDEX = find(strcmp(conditionNamesVector, nameCondition1));
    CON2_INDEX = find(strcmp(conditionNamesVector, nameCondition2));
end
