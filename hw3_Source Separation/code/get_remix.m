function [xhat_ans] = get_remix(s, h, W, H, K)
    % get the mixture phase
    phi = angle(s);
    for i=1:K
        % create masking filter
        Mask =  (W(:,i) * H(i,:) ./ (W*H));

        % filter
        XmagHat = s.*Mask; 

        % create upper half of frequency before istft
    %     XmagHat = [XmagHat; conj(XmagHat(end-1:-1:2,:))];

        % Multiply with phase
    %     XHat = XmagHat.*exp(1i*phi);

        % create upper half of frequency before istft
        xhat_ans(:, i) = real(invmyspectrogram(XmagHat.*exp(1i*phi), h))';
    end
    % sound(xhat_ans(:,1),fs)
    % sound(xhat_ans(:,2),fs)
    % sound(xhat_ans(:,3),fs)
end