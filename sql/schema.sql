CREATE TABLE t1
(
    operation_date timestamptz NOT NULL,
    id bigint NOT NULL,
    amount numeric(18,2) NOT NULL,
    state smallint NOT NULL,
    operation_guid uuid NOT NULL,
    message jsonb NOT NULL
)
PARTITION BY RANGE (operation_date);

COMMENT ON TABLE t1 IS 'Transactional operation table (t1)';

CREATE TABLE t1_2025_01 PARTITION OF t1
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE t1_2025_02 PARTITION OF t1
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE t1_2025_03 PARTITION OF t1
FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

CREATE TABLE t1_2025_04 PARTITION OF t1
FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');

CREATE UNIQUE INDEX ux_t1_operation_guid ON t1(operation_guid);

CREATE INDEX ix_t1_state ON t1(state);

CREATE INDEX ix_t1_client ON t1((message->>'clientId'));
