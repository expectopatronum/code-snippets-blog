function [ closest_date, idx ] = get_closest_date( dates, target_date, date_str_pattern, mode )
%get_closest_date get the closest date from a vector of datest
%dates
%target_date
%date_str_pattern
%mode one of 'before', 'after', 'any'

    dates_dn = datenum(dates, date_str_pattern);
    target_dn = datenum(target_date, date_str_pattern);
    date_diff = dates_dn - target_dn;

    if strcmp(mode, 'any')
        [~, idx] = min(abs(date_diff));
    else
        if strcmp(mode, 'before')
            date_diff(date_diff > 0) = -Inf;
            [~, idx] = max(date_diff);
        elseif strcmp(mode, 'after')
            date_diff(date_diff < 0) = Inf;
            [~, idx] = min(date_diff);
        else
           error('Mode %s is not valid.', mode);  
        end
    end
    closest_date = dates{idx};    
end

