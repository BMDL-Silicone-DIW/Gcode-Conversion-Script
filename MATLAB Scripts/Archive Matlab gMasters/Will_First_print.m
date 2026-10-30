close all; clear all; home;
tic;
%% setup
input_name = '';
output_name = '';
%input_name = 'Alignment-52_4-0_6.gcode';
%output_name = 'Alignment-52_4-0_6_mod1.gcode';
sdCard_dir = 'F:';

%factor = .0079; %blue nozzle
%101.98 multiple per 0.1mL
factor_start = 0.040; % updated to viscotec rednozzle



%% Reading in file
fprintf('Reading Gcode \n');
OG_code = gReaderCura(input_name);
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
    new_code = gModCura2(new_code,OG_code,factor_start,"Inner perimeter",0,0,5);
   
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
    code_layer = gModUApply(code_layer,factor_start,'infill',0,0,5);
    
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
