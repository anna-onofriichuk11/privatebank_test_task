CREATE OR REPLACE FUNCTION seed_t1(p_rows int)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

INSERT INTO t1
SELECT
    now() - (random() * interval '120 days'),
    gs,
    round((random()*1000)::numeric,2),
    (random()*1)::int,
    gen_random_uuid(),
    jsonb_build_object(
        'accountNumber', (100000 + random()*900000)::int,
        'clientId', (1 + random()*5000)::int,
        'operationType',
            CASE WHEN random()>0.5 THEN 'online' ELSE 'offline' END
    )
FROM generate_series(1,p_rows) gs;

END;
$$;
