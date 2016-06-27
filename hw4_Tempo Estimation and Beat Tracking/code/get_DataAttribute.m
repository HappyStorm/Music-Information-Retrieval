function [data] = get_DataAttribute(listOfGroundTruth, listOfChaChaCha,...
                                 listOfJive,        listOfNada,...
                                 listOfQuickstep,   listOfRumbaAmerican,...
                                 listOfRumbaInternational, listOfRumbaMisc,...
                                 listOfSamba, listOfTango,...
                                 listOfVienneseWaltz, listOfWaltz, Genres)
    data = cell(length(Genres), 111);

    % ChaChaCha
    data{1, 1}.numele = length(listOfChaChaCha);
    for i = 1 : length(listOfChaChaCha)
        data{1, i}.name = listOfChaChaCha{i};
        data{1, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfChaChaCha{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{1, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Jive
    data{2, 1}.numele = length(listOfJive);
    for i = 1 : length(listOfJive)
        data{2, i}.name = listOfJive{i};
        data{2, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfJive{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{2, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Nada
    data{3, 1}.numele = length(listOfNada);
    for i = 1 : length(listOfNada)
        data{3, i}.name = listOfNada{i};
        data{3, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfNada{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{3, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Quickstep
    data{4, 1}.numele = length(listOfQuickstep);
    for i = 1 : length(listOfQuickstep)
        data{4, i}.name = listOfQuickstep{i};
        data{4, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfQuickstep{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{4, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Rumba-American
    data{5, 1}.numele = length(listOfRumbaAmerican);
    for i = 1 : length(listOfRumbaAmerican)
        data{5, i}.name = listOfRumbaAmerican{i};
        data{5, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfRumbaAmerican{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{5, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Rumba-International
    data{6, 1}.numele = length(listOfRumbaInternational);
    for i = 1 : length(listOfRumbaInternational)
        data{6, i}.name = listOfRumbaInternational{i};
        data{6, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfRumbaInternational{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{6, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Rumba-Misc
    data{7, 1}.numele = length(listOfRumbaMisc);
    for i = 1 : length(listOfRumbaMisc)
        data{7, i}.name = listOfRumbaMisc{i};
        data{7, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfRumbaMisc{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{7, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Samba
    data{8, 1}.numele = length(listOfSamba);
    for i = 1 : length(listOfSamba)
        data{8, i}.name = listOfSamba{i};
        data{8, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfSamba{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{8, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Tango
    data{9, 1}.numele = length(listOfTango);
    for i = 1 : length(listOfTango)
        data{9, i}.name = listOfTango{i};
        data{9, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfTango{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{9, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % VienneseWaltz
    data{10, 1}.numele = length(listOfVienneseWaltz);
    for i = 1 : length(listOfVienneseWaltz)
        data{10, i}.name = listOfVienneseWaltz{i};
        data{10, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfVienneseWaltz{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{10, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Waltz
    data{11, 1}.numele = length(listOfWaltz);
    for i = 1 : length(listOfWaltz)
        data{11, i}.name = listOfWaltz{i};
        data{11, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfWaltz{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{11, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end


    % Rumba-American
    data{12, 1}.numele = length(listOfRumbaAmerican);
    for i = 1 : length(listOfRumbaAmerican)
        data{12, i}.name = listOfRumbaAmerican{i};
        data{12, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfRumbaAmerican{i});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{12, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Rumba-International
    data{12, 1}.numele = data{12, 1}.numele + length(listOfRumbaInternational);
    for i = length(listOfRumbaAmerican)+1 : data{12, 1}.numele
        data{12, i}.name = listOfRumbaInternational{i - length(listOfRumbaAmerican)};
        data{12, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfRumbaInternational{i - length(listOfRumbaAmerican)});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{12, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end

    % Rumba-Misc
    data{12, 1}.numele = data{12, 1}.numele + length(listOfRumbaMisc);
    for i = length(listOfRumbaAmerican) + length(listOfRumbaInternational) + 1 : data{12, 1}.numele
        data{12, i}.name = listOfRumbaMisc{i - (length(listOfRumbaAmerican) + length(listOfRumbaInternational))};
        data{12, i}.bpm = -1;
        [~, fn, ~] = fileparts(listOfRumbaMisc{i - (length(listOfRumbaAmerican) + length(listOfRumbaInternational))});
        for j = 1 : length(listOfGroundTruth)
            if isempty(strfind(listOfGroundTruth{j}, fn)), continue;
            else
                data{12, i}.bpm = load(listOfGroundTruth{j});
                break;
            end
        end
    end
end