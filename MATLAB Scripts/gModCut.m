%gModCut(code,cut start, cut end, move target);
function mod_code = gModCut(OG_code,i_start,i_end,i_target)

if i_target > i_end
    section1 = OG_code(1:i_start-1);
    section2 = OG_code(i_start:i_end);
    section3 = OG_code(i_end+1:i_target);
    section4 = OG_code(i_target+1:end);
    mod_code = [section1 section3 section2 section4];
elseif i_target<i_start
    section1 = OG_code(1:i_target);
    section2 = OG_code(i_target+1:i_start-1);
    section3 = OG_code(i_start:i_end);
    section4 = OG_code(i_end+1:end);
    mod_code = [section1 section3 section2 section4];
else
    mod_code = OG_code;
    fprintf('Error gModCut: Cut target is located within the cut section\n No changes to code made\n')
end

end