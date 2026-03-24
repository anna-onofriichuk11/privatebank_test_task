# privatebank_test_task
PostgreSQL Test Task for Private Bank vacancy

Implementation of partitioned transactional table `t1`.

Features:

* Range partitioning
* Data generator (100k rows)
* Scheduled insert/update jobs
* Materialized view aggregation
* Logical replication
* Optional .NET worker integration example


## Run order

1. schema.sql
2. seed.sql

```
select seed_t1(100000);
```

3. jobs.sql
4. aggregation.sql
5. replication.sql (optional)

