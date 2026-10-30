function [code_mod] = gModCornerApply(code,factor,type, layer_min, layer_max,tool)

time_pre = toc;

code_mod = code;
[Path_in, Path_out, Subdivisions, Distance] = gModCornerExtrusion(factor);

layer = layer_min;

k = 1;
exit = 0;
while exit ==0
    %find corner point
    if contains(string(code_mod(k).type),type) &&...
            contains(code_mod(k).command,'G1') &&...
            code_mod(k).layer >= layer_min && ...
            code_mod(k).layer <= layer_max &&...
            code_mod(k).tool == tool
        
        %start of corner
        pre = 0;
        ipre = k-1;
        while pre ==0
            if ~contains(code_mod(ipre).command,'G1') &&  ~contains(code_mod(ipre).command,'G0')
                ipre = ipre-1;
            else
                pre = 1;
            end
        end
        
        iaft = k+1;
        if ~contains(code_mod(iaft).command,'G1')
            iaft = k+2;
        end
        
        for j = ipre:iaft
            if contains(code_mod(j).command,'G92')
                for l = ipre:j
                    code_mod(l).e =0;
                end
            end
        end
        
        try
            [vec,angles,mag] = gMod2Vec(code_mod(ipre:iaft));
            sorted = sort(mag);
            if sorted(1) > Distance
%             if min(mag) > Distance
                [code_corner] = gModECorner(code_mod(ipre:iaft),mag,vec, angles, Path_in,Path_out,Distance,Subdivisions);
                na_check = cell2mat({code_corner.x});
                na_check2 = sum(isnan(na_check));
                if na_check2<1
                    code_mod = [code_mod(1:ipre-1),code_corner,code_mod(iaft+1:end)];
                    k = k+length(code_corner)+(ipre-iaft)-1;
                end
            end
        catch e
            fprintf('Code Mod %0.0f to %0.0f failed \n',ipre,iaft)
            fprintf(1,'   %s\n',e.identifier);
            fprintf(1,'   %s\n',e.message);
            for q = 1:length(e.stack)
                fprintf('      %s     line: %0.0f\n',e.stack(q).name,e.stack(q).line) 
            end
            fprintf(1,'   Code \n');
            for qs = ipre:iaft
                fprintf('       %s',code_mod(qs).raw);     
            end
            fprintf('\n');
        end
    end
    
    %exit point
    
    %{
    if layer ~= code_mod(k).layer
        time_now = toc;
        time_delta = time_now-time_pre;
        time_pre = time_now;
        if time_delta >0.02
            fprintf('     Corrected corner on layer %0.0f of %0.0f    layer time: %0.2f sec \n',layer,layer_max,time_delta);
        end
        layer = code_mod(k).layer;
    end
    %}
    if k >= length(code_mod)
        exit = 1;
    end
    k = k+1;
        
end

end