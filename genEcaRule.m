function ruleVec = genEcaRule(WolframNumber)
    Wbin = dec2bin(WolframNumber,8);
    Wbin = reverse(Wbin)';
    ruleVec = str2num(Wbin);
end
