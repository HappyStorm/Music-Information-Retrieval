function [NMF_W, NMF_H] = nmf_all(nmf_method, varargin)
    if nmf_method == 1
        V = varargin{1};
        K = varargin{2};
        MAXITER = varargin{3};
        beta = varargin{4};
        train = varargin{5};
        nVarargin = length(varargin);

        if nVarargin <= 5
            [NMF_W, NMF_H] = nmf(V, K, MAXITER, beta, train);
        else
            [NMF_W, NMF_H] = nmf(V, K, MAXITER, beta, train, varargin{6});
        end

    elseif nmf_method == 2
        V = varargin{1};
        K = varargin{2};
        tol = varargin{3};
        timelimit = varargin{4};
        maxiter = varargin{5};
        F = size(V,1);
        T = size(V,2);
        Winit = 1+rand(F, K);
        Hinit = 1+rand(K, T);

        [NMF_W, NMF_H] = nmf_ntu(V, Winit, Hinit, tol, timelimit, maxiter);
    end
end


% 
% Note:
%     This implementation of Non-Negative Matrix Decomposition is done by
%     the Center for Computer Research in Music and Acoustics (CCRMA) from
%     Stanford University.
%     
function [W_stanford, H_stanford] = nmf(V, K, MAXITER, beta, varargin)
    nVarargin = length(varargin);
    train = varargin{1};
    F = size(V,1);
    T = size(V,2);
    rand('seed',0);
    ONES = ones(F,T);

    if nVarargin <= 1
        W = 1+rand(F, K);
        H = 1+rand(K, T);
    else
        W = varargin{2};
        H = 1+rand(size(W, 2), T);
    end

    for i=1:MAXITER
        % KL-Divergence
        if beta==1
            % update activations
            H = H .* (W'*( V./(W*H+eps))) ./ (W'*ONES);
            % update dictionaries
            if train; W = W .* ((V./(W*H+eps))*H') ./(ONES*H'); end

        % Euclidean-Divergence
        elseif beta==2
            % update activations
            H = H .* ((W' * V) ./ (W' * W * H + eps));
            % update dictionaries
            if train; W = W .* ((V * H') ./ (W * H * H' + eps)); end
        end
    end

    % normalize W to sum to 1
    sumW = sum(W);
    W_stanford = W*diag(1./sumW);
    H_stanford = diag(sumW)*H;
end

% 
% Note:
%     This tool solves NMF by alternative non-negative least squares using
%     projected gradients. It converges faster than the popular
%     multiplicative update approach. Details and comparisons are in the
%     following paper: 
%         C.-J. Lin. Projected gradient methods for non-negative matrix factorization.
%         Neural Computation, 19(2007), 2756-2779.
%     
function [W_ntu, H_ntu] = nmf_ntu(V, Winit, Hinit, tol, timelimit, maxiter)
    % NMF by alternative non-negative least squares using projected gradients
    % Author: Chih-Jen Lin, National Taiwan University

    % W, H: output solution
    % Winit, Hinit: initial solution
    % tol: tolerance for a relative stopping condition
    % timelimit, maxiter: limit of time and iterations

    W_ntu = Winit; H_ntu = Hinit; initt = cputime;

    gradW = W_ntu * (H_ntu * H_ntu') - V*H_ntu';
    gradH = (W_ntu' * W_ntu) * H_ntu - W_ntu' * V;
    initgrad = norm([gradW; gradH'],'fro');
    fprintf('Init gradient norm %f\n', initgrad); 
    tolW = max(0.001, tol) * initgrad; tolH = tolW;

    for iter = 1 : maxiter,
        % stopping condition
        projnorm = norm([gradW(gradW<0 | W_ntu>0); gradH(gradH<0 | H_ntu>0)]);
        if projnorm < tol*initgrad || cputime-initt > timelimit, break; end
        
        [W_ntu, gradW, iterW] = nlssubprob(V', H_ntu', W_ntu', tolW, 1000);
        W_ntu = W_ntu'; gradW = gradW';
        if iterW==1, tolW = 0.1 * tolW; end
        
        [H_ntu, gradH, iterH] = nlssubprob(V, W_ntu, H_ntu, tolH, 1000);
        if iterH == 1, tolH = 0.1 * tolH; end
        if rem(iter, 10)==0, fprintf('.'); end
    end
    fprintf('\nIter = %d Final proj-grad norm %f\n', iter, projnorm);
end


function [H, grad, iter] = nlssubprob(V, W, Hinit, tol, maxiter)
    % H, grad: output solution and gradient
    % iter: #iterations used
    % V, W: constant matrices
    % Hinit: initial solution
    % tol: stopping tolerance
    % maxiter: limit of iterations

    H = Hinit; WtV = W' * V; WtW = W' * W; 

    alpha = 1; beta = 0.1;
    for iter = 1 : maxiter,  
        grad = WtW * H - WtV;
        projgrad = norm(grad(grad < 0 | H >0));
        if projgrad < tol, break; end
        
        % search step size
        for inner_iter = 1 : 20,
            Hn = max(H - alpha*grad, 0); d = Hn-H;
            gradd = sum(sum(grad.*d)); dQd = sum(sum((WtW*d).*d));
            suff_decr = 0.99 * gradd + 0.5 * dQd < 0;
            if inner_iter == 1, decr_alpha = ~suff_decr; Hp = H; end
            if decr_alpha,
                if suff_decr,
                    H = Hn; break;
                else
                    alpha = alpha * beta;
                end
            else
                if ~suff_decr | Hp == Hn,
                    H = Hp; break;
                else
                    alpha = alpha/beta; Hp = Hn;
                end
            end
        end
    end
    if iter==maxiter, fprintf('Max iter in nlssubprob\n'); end
end
