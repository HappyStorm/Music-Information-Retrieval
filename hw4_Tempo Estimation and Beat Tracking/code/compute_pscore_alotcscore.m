function [P_DFT, P_ACF, A_DFT, A_ACF, P_HYB, A_HYB] = compute_pscore_alotcscore(...
                                            Tempo_DFT, Saliency_DFT,  ...
                                            Tempo_ACF, Saliency_ACF,  ...
                                            Tempo_HYB, Saliency_HYB,  ...
                                            type, G)
    if strcmp(type, 'Normal')
        % P-Score for DFT
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Tt_DFT = zeros(1, 2);
        for i = 1 : length(Tempo_DFT)
           val = abs((G - Tempo_DFT(i)) / G);
           if val <= 0.08, Tt_DFT(i) = 1;
           else Tt_DFT(i) = 0; end
        end
        P_DFT = Saliency_DFT * Tt_DFT(1) + (1-Saliency_DFT) * Tt_DFT(2);


        % P-Score for ACF
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Tt_ACF = zeros(1, 2);
        for i = 1 : length(Tempo_ACF)
           val = abs((G - Tempo_ACF(i)) / G);
           if val <= 0.08, Tt_ACF(i) = 1;
           else Tt_ACF(i) = 0; end
        end
        P_ACF = Saliency_ACF * Tt_ACF(1) + (1-Saliency_ACF) * Tt_ACF(2);


        % ALOTC-Score for DFT
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        val_1 = abs((G - Tempo_DFT(1)) / G);
        val_2 = abs((G - Tempo_DFT(2)) / G);
        if (val_1 <= 0.08) || (val_2 <= 0.08), A_DFT = 1;
        else A_DFT = 0; end


        % ALOTC-Score for ACF
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        val_1 = abs((G - Tempo_ACF(1)) / G);
        val_2 = abs((G - Tempo_ACF(2)) / G);
        if (val_1 <= 0.08) || (val_2 <= 0.08), A_ACF = 1;
        else A_ACF = 0; end

        P_HYB = 0; A_HYB = 0;

    elseif strcmp(type, 'Hybrid')
        % P-Score for Hybrid
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Tt_Hybrid = zeros(1, 2);
        for i = 1 : length(Tempo_HYB)
           val = abs((G - Tempo_HYB(i)) / G);
           if val <= 0.08, Tt_Hybrid(i) = 1;
           else Tt_Hybrid(i) = 0; end
        end
        P_HYB = Saliency_HYB * Tt_Hybrid(1) + (1-Saliency_HYB) * Tt_Hybrid(2);


        % ALOTC-Score for Hybrid
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        val_1 = abs((G - Tempo_HYB(1)) / G);
        val_2 = abs((G - Tempo_HYB(2)) / G);
        if (val_1 <= 0.08) || (val_2 <= 0.08), A_HYB = 1;
        else A_HYB = 0; end

        P_DFT = 0; P_ACF = 0; A_DFT = 0; A_ACF = 0;
    end
end
