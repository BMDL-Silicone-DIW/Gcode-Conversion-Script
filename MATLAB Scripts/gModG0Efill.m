function [code_mod] = gModG0Efill(code,tool)

code_mod = code;
for i = 1:length(code)
   if contains(code(i).command,'G0') &&code(i).tool == tool && isempty(code(i).e)
      k = i-1;
      exit = 0;
      while exit ==0
          if ~isempty(code(k).e)
              code_mod(i).e = code(k).e;
              exit = 1;
          elseif k <= 0
              exit = 1;
          end
          k = k-1;
      end   
   end
end

end