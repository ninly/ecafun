function [field] = ecaFun(wolframNumber,N,M,firstRow,doPlot)
%% Input handling
    if nargin > 5
        error('ecaFun:TooManyInputs', ...
            'requires at most 3 optional inputs');
    end

    if nargin < 3 || isempty(M)
        M = 70;
    end

    if nargin < 4 || isempty(firstRow)
        % random initial state
        prev = round(rand(1,M));
    else
        if size(firstRow) ~= [1,M]
            error('initial state must be a row vector of length M');
        end
        prev = firstRow;
    end

    if nargin < 5
        doPlot = 1;
    end

    if nargin < 2
        error('ecaFun:notEnoughInputs', ...
            'Need at least a rule spec and number of iterations!');
    end

%% Generate ECA rule given Wolfram number
    ruleVector = genEcaRule(wolframNumber);

%% Iterate Elementary Cellular Automaton N times
    clear field;

    for jdx = 1:N
        neighborhoods = nan(M,3);
        neighborhoods(1,:) = [prev(end) prev(1:2)];
        neighborhoods(M,:) = [prev(M-1:M) prev(1)];

        for idx = 2:M-1
            neighborhoods(idx,:) = prev(idx-1:idx+1);
        end

        neighborhoods = bin2dec(num2str(neighborhoods));

        next = nan(1,M);
        for idx = 1:M
            next(idx) = ruleVector(neighborhoods(idx)+1);
        end

        if exist('field','var')
            field = [field;next];
        else
            field = [prev;next];
        end

        prev = next;
    end

%% Plot if desired
    if doPlot
        n = 1;
        figs(n) = figure; ax(n) = axes; pl(n) = imagesc(field);
        colormap([0.15 0.10 0.1;...
                  0.85 0.85 0.9]);
        ax(n).XTick = [];
        ax(n).YLabel.String = 'Iteration';
        ax(n).Title.String = ['ECA Rule ' num2str(wolframNumber)];
    end

end