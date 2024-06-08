CREATE OR REPLACE FUNCTION calculate_total_duration(serial_id integer)
RETURNS interval AS $$
DECLARE
    total_duration interval := '00:00:00';
    episode_duration interval;
	episode record;
BEGIN
    FOR episode IN
        SELECT e_duration
        FROM Episodes
        JOIN Seasons ON Episodes.e_idSeason = Seasons.ss_id
        WHERE Seasons.ss_idSerial = serial_id
    LOOP
        episode_duration := episode.e_duration;
        total_duration := total_duration + episode_duration;
    END LOOP;
	
    RETURN total_duration;
END;
$$ LANGUAGE plpgsql;
