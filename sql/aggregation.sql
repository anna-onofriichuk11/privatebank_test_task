CREATE MATERIALIZED VIEW mv_client_operation_sum
AS
SELECT
    (message->>'clientId')::int AS client_id,
    message->>'operationType' AS operation_type,
    SUM(amount) AS total_amount
FROM t1
WHERE state = 1
GROUP BY 1,2
WITH NO DATA;

CREATE OR REPLACE FUNCTION refresh_mv_on_state_change()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN

IF OLD.state = 0 AND NEW.state = 1 THEN
    REFRESH MATERIALIZED VIEW CONCURRENTLY mv_client_operation_sum;
END IF;

RETURN NEW;

END;
$$;

CREATE TRIGGER trg_refresh_mv
AFTER UPDATE ON t1
FOR EACH ROW
EXECUTE FUNCTION refresh_mv_on_state_change();
