function [code_mod] = gModG92(code,tool)

code_mod = code;

code92 = code(1);
code92(1) = [];
code92(1).e = 0;
code92(1).type = "Inner perimeter";
code92(1).command = 'G92';
code92(1).raw = "G92 E0";
code92(1).tool = tool;

i = 1;
layer = -1;
while i < length(code_mod)
    if code_mod(i).tool == tool && code_mod(i).layer >-2
        if contains(code_mod(i).command,'G92')
            code_mod(i) =[];
            i = i-1;
        end
        
        if code_mod(i).layer > layer
            layer = code_mod(i).layer;
            temp = code92;
            temp(end).layer = code_mod(i).layer;
            code_mod = [code_mod(1:i), temp, code_mod(i+1:end)];
            i = i+1;
        end
    end
    i = i+1;
end