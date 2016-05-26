
function dist = editDist2(inStr, dbStr, maxDist)
    
    % Base Case 2: Optimize recursive function with shortcircuiting
    if (maxDist < 0)
        dist = 0;
        return;
    end

    while (length(inStr) > 0) && (length(dbStr) > 0)
        if (inStr(1) ~= dbStr(1))
            d_rep = editDist(inStr(2:end), dbStr(2:end), maxDist-1);
            d_add = editDist(inStr, dbStr(2:end), maxDist-1);
            d_del = editDist(inStr(2:end), dbStr, maxDist-1);
            % m = findMin(d_rep, d_add, d_del);
            m = d_rep;
            if (d_add < m)
                m = d_add;
            end
            if (d_del < m)
                m = d_del;
            end
            dist = m+1;
            return;
        end
        
        inStr = inStr(2:end);
        dbStr = dbStr(2:end);
    end
    
    dist = numel(inStr) + numel(dbStr);
    
end

