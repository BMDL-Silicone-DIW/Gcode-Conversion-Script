close all; clear all; home;
tic;
%% setup
input_name = 'Gasket_5-13-21.gcode';
output_name = 'Gasket_5-13-21-mod.gcode';
%input_name = 'Alignment-52_4-0_6.gcode';
%output_name = 'Alignment-52_4-0_6_mod1.gcode';
sdCard_dir = 'F:';

%factor = .0079; %blue nozzle
%101.98 multiple per 0.1mL
factor_base_solid = 0.023*8; % updated to viscotec rednozzle
factor_base_wall = 0.023*8;
factor_solid = 0.0185*1;
factor_fill = 0.0185*1;
factor_wall = 0.0203*1.05;
factor_wall2 = 0.0203*1.05;
factor_solid2 = 0.0185*1;
factor_fill2 = 0.0185*1;

%% Reading in file
fprintf('Reading Gcode \n');
OG_code = gReaderCura(input_name);
rawlist = [OG_code(:).raw];
zretind = find(rawlist==";MATLAB_Z_RETURN_INSERT");
zlist = {OG_code.z};
zind = find(~cellfun(@isempty, zlist));
for i = zretind
    OG_code(i).command='G1';
    zind1 = zind-i;
    OG_code(i).z=1+zlist{i+min(zind1(zind1>0))};
    disp(i);
end
time1 = toc;
fprintf('Gcode Read\n');
fprintf('     Total Time: %0.2f sec\n\n',time1)
new_code = OG_code;
tic
fprintf('Modifying Gcode\n');
types = ["Inner perimeter","Outer perimeter","solid","infill","skirt"];

zlower = min([OG_code.layer]);
zupper = max([OG_code.layer]);

%% Cura tool corrections
%3.14*10^-5/.1*101.98 = 0.032
%mnw_code,OG_code,0.0314,types(2),0,zupper,5);
new_code = gModToolCura(new_code,1,4); %change tool 1 to tool 4
new_code = gModToolCura(new_code,0,5); %change tool 0 to tool 5

%new_code = gModG92(new_code,5);
%new_code = gModCuraContinutiy(new_code,5); %make sure continuity is maintained after all modifications


    %% extrusion modifications
    fprintf('     Modifying Extrusions\n');
    time_initial = toc;
    new_code = gModCura2(new_code,OG_code,factor_base_wall,"Inner perimeter",0,0,5);
    new_code = gModCura2(new_code,OG_code,factor_base_wall,"Outer perimeter",0,0,5);
    new_code = gModCura2(new_code,OG_code,factor_base_solid,"solid",0,0,5);
    new_code = gModCura2(new_code,OG_code,factor_base_solid,"infill",0,0,5);
    
   %{
    new_code = gModCura2(new_code,OG_code,factor_wall,"Inner perimeter",12,35,5);
    new_code = gModCura2(new_code,OG_code,factor_wall,"Outer perimeter",12,35,5);
    new_code = gModCura2(new_code,OG_code,factor_fill,"infill",12,35,5);
    new_code = gModCura2(new_code,OG_code,factor_solid,"solid",12,35,5);
    %}
    new_code = gModCura2(new_code,OG_code,factor_wall*1,"Inner perimeter",1,zupper,5);
    new_code = gModCura2(new_code,OG_code,factor_wall*1,"Outer perimeter",1,zupper,5);
    new_code = gModCura2(new_code,OG_code,factor_fill*1,"infill",1,zupper,5);
    new_code = gModCura2(new_code,OG_code,factor_solid*1,"solid",1,zupper,5);
    
        new_code = gModCura2(new_code,OG_code,factor_fill2*1,"infill",20,zupper,5);
    new_code = gModCura2(new_code,OG_code,factor_solid2*1,"solid",20,zupper,5);
     new_code = gModCura2(new_code,OG_code,factor_wall2*1,"Inner perimeter",15,zupper,5);
    new_code = gModCura2(new_code,OG_code,factor_wall2*1,"Outer perimeter",15,zupper,5);
    
    new_code = gModCuraContinutiy(new_code,5); %make sure continuity is maintained after all modifications
    
    partial_code = new_code;
    time_initial2 = toc;
    time_delta = time_initial2 - time_initial;
    fprintf('     Extrusions finished: %0.2f sec \n\n',time_delta)

    %% feature corrections
    
    fprintf('     Modifying features\n');
    new_code = gModG0Efill(new_code,5); %give all G0 commands a E value 
    
    time_initial = toc;
    layers = [new_code.layer];
    i_last = find(layers == 1,1,'last');
    lead_in = 5;
    
    code_layer = new_code(1:i_last);
    code_layer = gModCornerApply(code_layer,factor_base_wall,'perimeter',0,0,5);    
    code_layer = gModUApply(code_layer,factor_base_solid,'infill',0,0,5);
    
    new_code = [code_layer, new_code(i_last+1:end)];
    
    time_initial2 = toc;
    time_delta = time_initial2 - time_initial;
    fprintf('     Initial layers corrected, Time Elapsed: %0.2f sec \n',time_delta)
    
    
    
    for k = 1:zupper
        layers = [new_code.layer];
        i_first = find(layers == k,1,'first');
        i_last = find(layers == k,1,'last');
        lead_in = 5;
        try
            code_layer = new_code(i_first-lead_in:i_last);
            code_layer = gModCornerApply(code_layer,factor_wall,'perimeter',k,k,5);
            code_layer = gModUApply(code_layer,factor_fill,'infill',k,k,5);

            new_code = [new_code(1:i_first-1-lead_in), code_layer, new_code(i_last+1:end)];
        catch e
            fprintf('Layer %0.0f failed to feature correct \n',k)
            fprintf(1,'   %s\n',e.identifier);
            fprintf(1,'   %s\n',e.message);
            for q = 1:length(e.stack)
                fprintf('      %s     line: %0.0f\n',e.stack(q).name,e.stack(q).line) 
            end
        end
        
        time_initial2 = toc;
        time_delta = time_initial2 - time_initial;
        
        if mod(k,10) == 0
            %scratch3
            fprintf('     Layer %0.0f of %0.0f corrected, Time Elasped: %0.2f sec\n',k,zupper,time_delta)

        end
    end
%     new_code = gModCura2(new_code,OG_code,factor_solid,"Inner perimeter",0,1,5);
%     new_code = gModCura2(new_code,OG_code,factor_solid,"Outer perimeter",0,1,5);
%     new_code = gModCura2(new_code,OG_code,factor_solid,"solid",0,1,5);
%     
%     new_code = gModCura2(new_code,OG_code,factor_wall,"Inner perimeter",3,zupper,5);
%     new_code = gModCura2(new_code,OG_code,factor_wall,"Outer perimeter",3,zupper,5);
%     new_code = gModCura2(new_code,OG_code,factor_fill,"solid",3,zupper,5);
%     
%     new_code = gModCura2(new_code,OG_code,factor_solid,"Inner perimeter",9,zupper,5);
%     new_code = gModCura2(new_code,OG_code,factor_solid,"Outer perimeter",9,zupper,5);
%     new_code = gModCura2(new_code,OG_code,factor_solid,"solid",9,zupper,5);

%     new_code = gModCura2(new_code,OG_code,factor_fill,"infill",0,zupper,5);
% 
%     new_code = gModCura2(new_code,OG_code,factor_wall*1,"Inner perimeter",2,zupper,5);
%     new_code = gModCura2(new_code,OG_code,factor_wall*1,"Outer perimeter",2,zupper,5);
%     new_code = gModCura2(new_code,OG_code,factor_base*1,"solid",4,zupper,5);
    
    
%% error correcting
    new_code = gModCuraContinutiy(new_code,5); %make sure continuity is maintained after all modifications

%% writing to file
time2 = toc;
fprintf('Gcode Modified\n');
fprintf('     Total Time: %0.2f sec\n\n',time2)

tic
fprintf('Writing Gcode to File\n');

gWriterCura(new_code,output_name)
time3 = toc;
fprintf('Gcode saved\n');
fprintf('     Total Time: %0.2f sec\n\n',time3)


fprintf('Attempting to save to SD card\n');
try
    outDir = fullfile(sdCard_dir);
    copyfile(output_name, outDir);
    fprintf([output_name,' Saved to SD Card in Directory ', sdCard_dir, '\n'])
catch
    fprintf(['     No SD Card Found in Directory ', sdCard_dir, '\n'])
end
