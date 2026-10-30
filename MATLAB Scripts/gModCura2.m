%close all; clear all;
%file = 'Part_1_scaled_simplfy.gcode';
%code = gReader(file);

%load('Part_1_scaled.mat')
function code_mod = gModCura2(code,OG_code,ratio,type,zlower,zupper,tool)

code_mod = code;

%Q = 0.2478f + 1.5441
e_cur = 0;
for i = 2:length(code_mod)
    if ~isempty(code_mod(i-1).e)
        e_cur = code_mod(i-1).e;
    end
    if contains(code_mod(i).type,type) && code_mod(i).tool == tool ...
            && code_mod(i).layer >= zlower...
            && code_mod(i).layer <= zupper...
            && contains(string(code_mod(i).command),'G1')
            
            if ~isempty(code_mod(i-1).x)
                x1 = code_mod(i-1).x;
                y1 = code_mod(i-1).y;
            else
                k = 2;
                x1 = code_mod(i-k).x;
                y1 = code_mod(i-k).y;
                while isempty(x1)
                    k = k+1;
                    x1 = code_mod(i-k).x;
                    y1 = code_mod(i-k).y;
                end
            end
                
            x2 = code_mod(i).x;
            y2 = code_mod(i).y;
            if isempty(x2)
                x2 = x1;
                y2 = y1;
            end

            deltaD =  ((x2-x1)^2+(y2-y1)^2)^.5;
            %if ~isempty(code_mod(i-1).e)
                code_mod(i).e = e_cur+deltaD*ratio;
            %end

    end
    if isempty(code_mod(i).e) && ~isempty(code_mod(i-1).e)&& code_mod(i).command == "G1"
        code_mod(i).e = code_mod(i-1).e;
    end
    
    if isempty(code_mod(i-1).e) && code_mod(i-1).command == "G1"
        code_mod(i-1).e = [];
    end
    if contains(string(code_mod(i).command),'G92')
        code_mod(i).e = 0;
    end
end

end
