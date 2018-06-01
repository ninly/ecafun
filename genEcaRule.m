function ruleVec = genEcaRule(wolframNumber)
    if wolframNumber > 255
        error('genEcaRule:ValueError',...
            'Wolfram number must be in the range 0-255')
    end
    Wbin = dec2bin(wolframNumber,8);
    Wbin = reverse(Wbin)';
    ruleVec = str2num(Wbin);
end
