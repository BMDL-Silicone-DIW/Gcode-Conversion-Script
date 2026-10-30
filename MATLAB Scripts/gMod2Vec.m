function [vec,angles,mag] = gMod2Vec(code)
%Remove nonmovement commands
comment_index = [];
for i = 1:length(code)
    if ~contains(code(i).command,'G1')&&~contains(code(i).command,'G0')
        comment_index(end+1) = i;
    end
end
code(comment_index) = [];

%find xy cords
x = zeros(1,length(code));
y = zeros(1,length(code));
for i = 1:length(code)
    try
        x(i) = code(i).x;
        y(i) = code(i).y;
    catch
        disp(i)
        if i>1
            x(i) = code(i-1).x;
            y(i) = code(i-1).y;
        else
            x(i) = code(i+1).x;
            y(i) = code(i+1).y;
        end
        disp("no x/y coords, inserting previous/next values")
    end
end

%vector, magnitude, and angle math;
vec = [[x(2:end)-x(1:end-1)]',[y(2:end)-y(1:end-1)]'];
mag = gModVecMag(vec)';
vec = vec./mag;
angles = acos(dot(vec(2:end,:),vec(1:end-1,:),2)./(mag(2:end).*mag(1:end-1)));
%angles = angles'

end