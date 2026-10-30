function Mod_code = gModInsert(OG_code,insert_line,target)
    section1 = OG_code(1:target);
    section2 = OG_code(target+1:end);
    
    Mod_code = [section1 insert_line section2];
end