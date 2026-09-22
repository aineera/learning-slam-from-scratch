% Loop Closure - Purani jagah pehchanna
function is_loop = loop_closure(old_place, new_place)
    if strcmp(old_place, new_place)
        disp('Haan! Robot wapas purani jagah par aa gaya');
        is_loop = true;
    else
        disp('Nahi, ye nayi jagah hai');
        is_loop = false;
    end
end

% Example: loop_closure('Class A', 'Class A')
