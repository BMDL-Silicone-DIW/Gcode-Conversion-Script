function code_mod = gModCuraContinutiy(code,tool)
    %intial variables
    code_mod = code;
    delta = 0;
    e_cur = 0;
    x_cur = 0;
    y_cur = 0;
    d_cur = 0;
    e_delta = 0;
    
    e_pre = 0;
    x_pre = 0;
    y_pre = 0;

    ratio_standard = 0.02; %standard ratio for continutity between layers
    ratio_limit = 0.1; %limit to determine 
    
    ratio_pre = 0;
    ratio_cur = 0;
   k = 1;
   
   exit = 0;
   
   %finding first real cordinate; 
   while exit ~=1 
       if code_mod(k).layer>=0
           if ~isempty(code_mod(k).x)
               x_cur = code_mod(k).x;
           end

           if ~isempty(code_mod(k).x)
               y_cur = code_mod(k).y;
           end

           if x_cur>0 &&y_cur > 0
               exit = 1;
           end
       end
       k = k+1;
   end
       
   for i = k:length(code_mod)
      if code_mod(i).tool == tool
          %find travel distance
           if ~isempty(code_mod(i).x)
               x_pre = x_cur;
               y_pre = y_cur;
               x_cur = code_mod(i).x;
               y_cur = code_mod(i).y;
               
               d_cur = ((x_cur-x_pre)^2+(y_cur-y_pre)^2)^.5;
           end

           
           %find e_delta
           if ~isempty(code_mod(i).e)
               e_pre = e_cur;
               e_cur = code_mod(i).e;
               e_delta = e_cur-e_pre;
               
               %find ratio
               ratio_pre = ratio_cur;
               ratio_cur = abs(e_delta)/d_cur;
               if round(ratio_cur,5) ~= round(ratio_pre,5)
                   %ratio_cur
               end
               
               %sanity check the extrusion
               if round(ratio_cur,5) > ratio_limit && ~contains(code_mod(i).type, "correction")
                   delta= delta+e_delta-d_cur*ratio_standard;
               end
               code_mod(i).e = e_cur-delta;
               
           end
           %catch for G92 reset
           if contains(code_mod(i).command,'G92')
               delta = 0;
               code_mod(i).e = 0;
               e_cur = 0;
           end
      end
   end

end