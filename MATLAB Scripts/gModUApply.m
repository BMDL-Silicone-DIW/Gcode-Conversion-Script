function [code_mod] = gModUApply(code,factor,type, layer_min, layer_max,tool)
time_pre = toc;

layer = layer_min;
angle_threshold = round(pi,2);
mag_index = 2;
code_mod = code;
[Path_in, Path_out, Subdivisions, Distance] = gModUExtrusion(factor);

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
            if ~contains(code_mod(ipre).command,'G')
                ipre = ipre-1;
            else
                pre = 1;
            end
        end
        
        iaft = k+2;
        if ~contains(code_mod(iaft).command,'G1')
            iaft = k+3;
        end
        
        [vec,angles,mag] = gMod2Vec(code_mod(ipre:iaft));
        
        %checking case for U for 180 turn. 
        angle_check = round(sum(angles),2);
        
        %checking to small leg is the "middle" of U
        mag_minI = find(mag == min(mag),1,'first');
        
        %vec check. The incoming and outgoing vectors need to cancel;
        vec_check = sum(vec(1,:)+vec(end,:));
        
        if angle_check == angle_threshold &&...
                mag_minI ==mag_index && ...
                vec_check == 0 
           %found proper corner 
           
           
           %trouble shooting area;
           %{
           x = zeros(length(code2(ipre:iaft)),1);
           y = zeros(length(code2(ipre:iaft)),1);
           for j = 1:length(code2(ipre:iaft))
               x(j) = code2(j+ipre-1).x;
               y(j) = code2(j+ipre-1).y;
           end

           plot(x,y)
           plot(x,y)
           %c
           %}
            sorted = sort(mag);
            
            if sorted(2) > Distance
                [code_corner] = gModEU(code_mod(ipre:iaft),mag,vec, angles, Path_in,Path_out,Distance,Subdivisions);

                code_mod = [code_mod(1:ipre-1),code_corner,code_mod(iaft+1:end)];
                k = k+length(code_corner)+(ipre-iaft)-1;
            end
        end
    
    end
    
    %{
    if layer ~= code_mod(k).layer
        time_now = toc;
        time_delta = time_now-time_pre;
        time_pre = time_now;
        if time_delta >0.2
            fprintf('     Correcting U on layer %0.0f of %0.0f    layer time: %0.2f sec \n',layer,layer_max,time_delta);
        end
        layer = code_mod(k).layer;
    end
    %}
    %exit point
    if k >= length(code_mod)
        exit = 1;
    end
    k = k+1;

end

end