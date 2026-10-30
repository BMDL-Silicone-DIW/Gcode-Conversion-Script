function [] = gWriterCura(code,name)

%fileID = fopen(name,'w','n','UTF-8');
fileID = fopen(name,'w');

    for i = 1:length(code)
        if ~contains(string(code(i).command),'G1') && ~contains(string(code(i).command),'G0')
            line = [string(code(i).raw)+'\n'];
            fprintf(fileID,line);
            clear line;
        elseif contains(string(code(i).command),'G1')
            line = "G1";
            if ~isempty(code(i).x)
                line = [line+" X"+string(code(i).x)];
            end
            if ~isempty(code(i).y)
                line = [line+" Y"+string(code(i).y)];
            end
            if ~isempty(code(i).z)
                line = [line+" Z"+string(code(i).z)];
            end
            if ~isempty(code(i).e)
                    line = [line+" E"+string(sprintf('%0.6g',code(i).e))];
            end
            if ~isempty(code(i).f)
                line = [line+" F"+string(code(i).f)];
            end
            line = [line+";\n"];
            fprintf(fileID,line);
            clear line;
        elseif contains(string(code(i).command),'G0')
            line = "G0";
            if ~isempty(code(i).x)
                line = [line+" X"+string(code(i).x)];
            end
            if ~isempty(code(i).y)
                line = [line+" Y"+string(code(i).y)];
            end
            if ~isempty(code(i).z)
                line = [line+" Z"+string(code(i).z)];
            end
            %{
            if ~isempty(code(i).e)
                    line = [line+" E"+string(sprintf('%0.6g',code(i).e))];
            end
            %}
            if ~isempty(code(i).f)
                line = [line+" F"+string(code(i).f)];
            end
            line = [line+";\n"];
            fprintf(fileID,line);
            clear line;
        end
    end
fprintf(fileID,";Gcode End");
fclose(fileID);
end