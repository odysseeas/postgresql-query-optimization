-- Step 4: server tuning

-- Memory: shared_buffers 128MB (default) -> 512MB
ALTER SYSTEM SET shared_buffers = '512MB';

-- Parallelism: allow up to 4 workers per Gather node
ALTER SYSTEM SET max_parallel_workers_per_gather = 4;

-- ALTER SYSTEM only writes postgresql.auto.conf:
--   * max_parallel_workers_per_gather takes effect after: SELECT pg_reload_conf();
--   * shared_buffers takes effect only after a server restart.
-- Check the active values with: SHOW shared_buffers; SHOW max_parallel_workers_per_gather;
