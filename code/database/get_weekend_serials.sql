CREATE OR REPLACE FUNCTION get_weekend_serials(user_id INT)
RETURNS TABLE (
    serial_id INT,
    serial_name TEXT,
    serial_description TEXT,
    total_duration INTERVAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.s_id,
        s.s_name,
        s.s_description,
        sum(e.e_duration) as total_duration
    FROM 
        Serials s
        JOIN Serials_Favourites sf ON s.s_id = sf.sf_idSerial
        JOIN Favourites f ON sf.sf_idFavourite = f.f_id
        JOIN Users u ON u.u_idFavourites = f.f_id
        JOIN Seasons ss ON ss.ss_idSerial = s.s_id
        JOIN Episodes e ON e.e_idSeason = ss.ss_id
    WHERE 
        u.u_id = user_id
        AND s.s_state = 'завершен'
    GROUP BY 
        s.s_id, s.s_name, s.s_description
    HAVING 
        sum(e.e_duration) <= INTERVAL '48 hours';
END;
$$ LANGUAGE plpgsql;
