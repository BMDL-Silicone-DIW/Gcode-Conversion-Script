function [code] = gReaderCura(file)

gcode = fopen(file);

%ititializae structure fields
f1 = 'layer';
v1 = 0;
f2 = 'raw';
v2 = '';
f3 = 'type';
v3 = '';
f4 = 'command';
v4 = '';
f5 = 'x';
v5 = [];
f6 = 'y';
v6 = [];
f7 = 'z';
v7 = [];
f8 = 'e';
v8 = [];
f9 = 'f';
v9 = 0;
f10 = 'tool';
v10 = 0;

code = struct(f1,v1,f2,v2,f3,v3,f4,v4,f5,v5,f6,v6,f7,v7,f8,v8,f9,v9,f10,v10);

clear f1 v1 f2 v2 f3 v3 f4 v4 f5 v5 f6 v6 f7 v7 f8 v8 f8 v8 f9 v9 f10 v10
layer = -10;
line_num = 1;
type = 'start';
tool = 0;

raw_code = fread(gcode,inf,'uint8=>char');
raw_code = raw_code';
raw_code = strsplit(raw_code,'\n');
exit_flag = 0;

for j = 1:length(raw_code)

    line = string(raw_code(j));
    code(line_num).raw = line;


    [splitLine,matches] = strsplit(line, {';','G','M','S',' ','T','X','Y','Z','E','F'},'CollapseDelimiters',false);

    matches = string(matches);
    tool_flag = 0;
    comment_flag = 0;
    for i = 1:length(matches)
        switch matches(i)
            case ';'
                if i<2
                    code(line_num).command = 'Comment';
                end
                comment_flag = 1;
                %Comment handleing \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                [comment_splitLine,comment_matches] = strsplit(line, {'LAYER:','TYPE:','End of Gcode'},'CollapseDelimiters',false);
                for k = 1:length(comment_matches)
                    switch comment_matches(k)
                        case 'End of Gcode'
                            exit_flag = 1;
                        case 'LAYER:'
                            layer = negcatch(comment_splitLine{k+1});                
                        case 'TYPE:'
                            [~,type_match] = strsplit(line,{'SUPPORT-INTERFACE','SUPPORT','SKIRT'...
                                'SKIRT','WALL-INNER','WALL-OUTER','SKIN','FILL','SILICONE-END',...
                                'SILICONE-START','PLASTIC-START','PLASTIC-END'});
                            switch type_match(1)
                                case 'SUPPORT-INTERFACE'
                                    type = "Support Interface";
                                case 'SUPPORT'
                                    type = "Support";
                                case 'SKIRT'
                                    type = "Skirt";
                                case 'WALL-INNER'
                                    type = "Inner perimeter";
                                case 'WALL-OUTER'
                                    type = "Outer perimeter";
                                case 'SKIN'
                                    type = "solid";
                                case 'FILL'
                                    type = "infill";
                                case 'SILICONE-START'
                                    type = "Silicone-start";
                                case 'SILICONE-END'
                                    type = "Silicone-end";
                                case 'PLASTIC-START'
                                    type = "Plastic-start";
                                case 'PLASTIC-END'
                                    type = "Plastic-end";
                                otherwise
                                    type = "Unknown";
                            end
                    end
                end
             %Comment handleing \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            case 'G'
                if comment_flag ~= 1
                    code(line_num).command = ['G',splitLine{i+1}];
                end
            case 'M'
                if comment_flag ~= 1
                    code(line_num).command = ['M',splitLine{i+1}];
                    tool_flag = 1; 
                end
            case 'S'
                if comment_flag ~= 1
                    code(line_num).command = [code(line_num).command,' S',splitLine{i+1}];
                end
            case 'T'
                if comment_flag ~= 1 && tool_flag ~=1
                    tool = str2double(splitLine{i+1});
                    code(line_num).tool = tool;
                    code(line_num).command = ['T',splitLine{i+1}];
                end
            case 'X'
                if comment_flag ~= 1
                    x = negcatch(splitLine{i+1});  
                    code(line_num).x = x;
                end
            case 'Y'
                if comment_flag ~= 1
                    y = negcatch(splitLine{i+1});
                    code(line_num).y = y;
                end
            case 'Z'
                if comment_flag ~= 1
                    z = negcatch(splitLine{i+1});
                    code(line_num).z = z;
                end
            case 'E'
                if comment_flag ~= 1
                    e = negcatch(splitLine{i+1});
                    code(line_num).e = e;
                end
            case 'F' 
                if comment_flag ~= 1
                    f = str2double(splitLine{i+1});
                    code(line_num).f = f;
                end
        end
    end
    
    code(line_num).type = string(type);
    code(line_num).layer = layer;
    code(line_num).tool = tool;
    line_num = line_num+1;
    if exit_flag == 1
        break
    end
end
fclose('all');

end

function [value] = negcatch(input)
    neg_input = strsplit(input,'-');
    if length(neg_input)>1
        value = -str2num(neg_input{2});
    else 
        value = str2num(neg_input{1});
    end
end