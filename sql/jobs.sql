CREATE EXTENSION IF NOT EXISTS pg_cron;

CREATE OR REPLACE FUNCTION add_record()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

INSERT INTO t1
SELECT
    now(),
    floor(random()*1000000),
    round((random()*1000)::numeric,2),
    0,
    gen_random_uuid(),
    jsonb_build_object(
        'accountNumber', (100000 + random()*900000)::int,
        'clientId', (1 + random()*5000)::int,
        'operationType',
            CASE WHEN random()>0.5 THEN 'online' ELSE 'offline' END
    );

END;
$$;

CREATE OR REPLACE FUNCTION process_state()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE sec int;
BEGIN

sec := extract(second from clock_timestamp());

IF sec % 2 = 0 THEN
    UPDATE t1 SET state = 1 WHERE state = 0 AND id % 2 = 0;
ELSE
    UPDATE t1 SET state = 1 WHERE state = 0 AND id % 2 = 1;
END IF;

END;
$$;

SELECT cron.schedule('t1_insert','*/5 * * * * *',$$select add_record();$$);
SELECT cron.schedule('t1_update','*/3 * * * * *',$$select process_state();$$);
