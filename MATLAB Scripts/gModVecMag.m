function mag = gModVecMag(m)

for i = 1:size(m,1)
    mag(i) = norm(m(i,:));
end


end