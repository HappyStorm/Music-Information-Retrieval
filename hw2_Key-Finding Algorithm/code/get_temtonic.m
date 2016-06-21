function [result_BI] = get_temtonic(tonic)
    BI_templates = [
        1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1
        1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0
    ];

%     BI_templates = [
%         6.35, 2.23, 3.48, 2.33, 4.38, 4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88
%         6.33, 2.68, 3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17
%     ];

    if tonic >= 12
        tonic = tonic - 12;
        template_binary = BI_templates(2, :);
    else
        template_binary = BI_templates(1, :);
    end
    
    result_BI = circshift(template_binary, [0, mod(tonic-3,12)]);
end