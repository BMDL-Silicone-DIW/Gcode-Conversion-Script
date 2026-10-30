function code_in = gModToolCura(code_in,tool_before,tool_after)
    for i = 1:length(code_in)
        if code_in(i).tool == tool_before
            code_in(i).tool = tool_after;
            if contains(string(code_in(i).command),'T')&& ~contains(string(code_in(i).command),'M')
                code_in(i).raw = "T"+string(tool_after);
                code_in(i).command = "T"+string(tool_after);
            end
        end
    end
end