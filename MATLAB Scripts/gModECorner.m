function [code_mod] = gModECorner(code,mag,vec, angle, E_pathPre,E_pathPost,Distance,Subdivisions)
%find the comments and save them
comment_index = [];
f = fieldnames(code)';
f{2,1} = {};
comments = struct(f{:});

%Remove nonmovement commands
comment_index = [];
for i = 1:length(code)
    if ~contains(code(i).command,'G1')&&~contains(code(i).command,'G0')
        comment_index(end+1) = i;
        comments(end+1) = code(i);
    end
end
code(comment_index) = [];

if length(code)>2
    %find B index;


    %finding the x,y of the B cord    
    B_cord(1,:) = [code(2).x,code(2).y];
    if length(code) == 4
        B_cord(2,:) = [code(3).x,code(3).y];
    end

    %finding the cut locations
    Pre_cord(1,:) = [B_cord(1,:)+vec(1,:)*-Distance,0]; 
    %Post_cord(1,:) = B_cord+vec(1,:)*Distance; 

    %find the starting E value and apply it to the G_code Structure;
    Delta_E = code(2).e-code(1).e;
    E_ratio = 1-Distance/mag(1);
    E_new = code(1).e+Delta_E*E_ratio;
    code_mod = code(1);
    code_mod(end+1).x = Pre_cord(1,1);
    code_mod(end).y = Pre_cord(1,2);
    code_mod(end).e = E_new;
    Pre_cord(1,3) = E_new;

    %before Corner
    for i = Subdivisions-1:-1:0
        Pre_cord(end+1,:) = [B_cord(1,:)+vec(1,:)*-Distance*i/Subdivisions,0]; 
        Pre_cord(end,3) = E_new+E_pathPre(Distance-Distance*i/Subdivisions);
        code_mod(end+1).x = Pre_cord(end,1);
        code_mod(end).y = Pre_cord(end,2);
        code_mod(end).e = Pre_cord(end,3);
    end

    if length(code) == 4
        B_index = 2;
        code_mod(end+1) = code(3);
        code_mod(end).e = E_new+E_pathPost(Distance*1/Subdivisions)+E_pathPre(Distance);
    else
        B_index = 1;
    end

    Post_cord = [];
    %after corner
    if ~contains(code(end).command,'G0')
        for i = 2:Subdivisions
            Post_cord(end+1,:) = [B_cord(B_index,:)+vec(B_index+1,:)*Distance*i/Subdivisions,0]; 
            Post_cord(end,3) = E_new+E_pathPost(Distance*i/Subdivisions)+E_pathPre(Distance);
            code_mod(end+1).x = Post_cord(end,1);
            code_mod(end).y = Post_cord(end,2);
            code_mod(end).e = Post_cord(end,3);
        end
        code_mod(end+1) = code(end);
    else
        code_mod(end+1) = code(end);
        code_mod(end).e = code_mod(end-1).e;
    end
    %completing the "corner"


    %house keeping the G-code structure
    for i = 2:length(code_mod)-1
        if isempty(code_mod(i).type)
            code_mod(i).layer = code(end).layer;
            code_mod(i).type = "Corner correction";
            code_mod(i).command = 'G1';
            code_mod(i).tool = code(end).tool;
        end
    end

    if code_mod(end).e ~=code(end).e
        %fprintf('something is wrong')
    end
    %{

    if length(code) == 3
        X = [code(1).x,code(2).x,code(3).x]';
        Y = [code(1).y,code(2).y,code(3).y]';
        E = [code(1).e,code(2).e,code(3).e]';
    elseif length(code) == 4
        X = [code(1).x,code(2).x,code(3).x,code(4).x]';
        Y = [code(1).y,code(2).y,code(3).y,code(4).y]';
        E = [code(1).e,code(2).e,code(3).e,code(4).e]';
    end
    for i = 1:length(code_mod)
       X2(i) = code_mod(i).x; 
       Y2(i) = code_mod(i).y; 
       E2(i) = code_mod(i).e; 
    end

    dX = X(2:end)-X(1:end-1);
    dY = Y(2:end)-Y(1:end-1);
    D = (dX.^2+dY.^2).^0.5;
    D = cumsum(D);

    dX2 = X2(2:end)-X2(1:end-1);
    dY2 = Y2(2:end)-Y2(1:end-1);
    D2 = (dX2.^2+dY2.^2).^0.5;
    D2 = cumsum(D2);


    figure; hold on;

    plot(X2,Y2,'b','linewidth',5)
    plot(X,Y,'k','linewidth',2);
    legend('Mod','Orginal');

    figure; hold on;

    %plot([0;Dbc],Pre_cord(:,3),'b')
    %plot([Dbc(end);Dbc(end)+Dac],Post_cord(:,3),'r')
    plot([0,D2],E2,'b','linewidth',1)
    plot([0;D],E,'k');
    legend('mod','Orginal');
    %}

    if code_mod(1).e ~=code(1).e
        %fprintf('something is wrong')
    end

    %putting the comments back in cause they help :\
    code_mod = [comments code_mod];

    if code_mod(end).e ~=code(end).e
        %fprintf('something is wrong')
    end
else
    code_mod = code; %catch incase the code put in something short
end

end