function [Mod_code,skirt_index] = gModSkirtCura(OG_code,tool,off_x,off_y)
    Mod_code = OG_code;
    
    layer = [OG_code.layer]';
    tools = [OG_code.tool]';
    type = [OG_code.type]';
    
    
    skirt_find = find(type == 'Skirt')'; %find all skirt gcode commands
    tool_find = find(tools == tool)'; %find all gcode commands using Tool X
    
    type_tool = intersect(skirt_find,tool_find)'; %toolX and skirt overlap
    layer_intersect = [type_tool,layer(type_tool)];
    
    layer_target = unique(layer(type_tool)); %layers where skirt command needs to be moved to become plastic
    
    %find plastic start of plastic regions
    plastic_find = find(type == 'Plastic-start');
    layer_plastic = [layer(plastic_find),plastic_find];
    
    %create G92 command to insert for plastic skirt to account change in
    % Gcode file 
    f = fieldnames(Mod_code)';
    f{2,1} = {};
    plastic_correction = struct(f{:});
    plastic_correction(1).raw ="G92 E0;\n";
    plastic_correction(1).command = 'G92';
    plastic_correction(1).e = 0;
    plastic_correction(1).tool = 4;
    plastic_correction(1).type = 'Skirt';
    
    skirt_index = zeros(length(layer_target),4);

    
    for i = 1:length(layer_target)
        type = [Mod_code.type]';
        layer = [Mod_code.layer]';
        tools = [Mod_code.tool]';
        
        skirt_find = find(type == 'Skirt')'; %find all skirt gcode commands
        tool_find = find(tools == tool)'; %find all gcode commands using Tool X
    
        type_tool = intersect(skirt_find,tool_find)'; %toolX and skirt overlap
        layer_intersect = [type_tool,layer(type_tool)];  

        %find plastic start of plastic regions
        plastic_find = find(type == 'Plastic-start');
        layer_plastic = [layer(plastic_find),plastic_find];
        
        %layer of change
        skirt_index(i,1) = layer_target(i);
        
        %find start of skirt index region
        [first,~] = find(layer_intersect(:,2)==layer_target(i),1,'first');
        skirt_index(i,2)= layer_intersect(first,1);
        first = layer_intersect(first,1);
        
        %find end of skirt index region
        [last,~] = find(layer_intersect(:,2)==layer_target(i),1,'last');
        skirt_index(i,3)= layer_intersect(last,1);
        last = layer_intersect(last,1);
        
        %find insertion point, start of plastic printing for layer
        [target,~] = find(layer_plastic(:,1) == layer_target(i),1,'last');
        skirt_index(i,4) = layer_plastic(target,2);
        target = layer_plastic(target,2);
   
        %keep premove for plastic skirt
        plastic_keep = Mod_code(first-1);
        plastic_keep.tool = 4; 
        plastic_keep.x = plastic_keep.x-off_x;
        plastic_keep.y = plastic_keep.y-off_y;
        
        %keep premove for silicone
        silicone_keep = Mod_code(last);
        
        %adjust e-values of skirt region to start at zero
        min_e = min([OG_code(first:first+10).e]); %find starting E value in skirt

        for j = first:last
            if ~isempty(Mod_code(j).e)
                Mod_code(j).e = Mod_code(j).e-min_e;
            end
          %Change skirt tool entry to plastic
            Mod_code(j).tool = 4;
          % Change x and y values by offset
            Mod_code(j).x = Mod_code(j).x-off_x;
            Mod_code(j).y = Mod_code(j).y-off_y;
        end

        
        %Cut and move skirt to insertion point
        Mod_code = gModCut(Mod_code,first,last,target);
        
        %Move calculated "start" of plastic to after skirt. 
        Mod_code(target-(last-first)-1).tool = 4;
        Mod_code = gModCut(Mod_code,target-(last-first)-1,target-(last-first)-1,target);
        
        %Insert plastic G92 command to correct e values after inserted
        %skirt region. 
        plastic_correction(1).layer = skirt_index(i,1);
        Mod_code = gModInsert(Mod_code,plastic_correction,target);
        
        %Insert plastic skirt premove command
        Mod_code =gModInsert(Mod_code,plastic_keep,target-(last-first)-1);
        
        %Insert silicone wall premove command
        Mod_code = gModInsert(Mod_code,silicone_keep,first);
        
    end
   

end
