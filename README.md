# PostgreSQL Query Optimization

Benchmarking and tuning analytical SQL queries in PostgreSQL on UK road-safety data, using `EXPLAIN ANALYZE` to understand every change.

Coursework for *Database Management Systems*, Department of Informatics, University of Piraeus (2025–26).

## Data

[UK Road Safety: Traffic Accidents and Vehicles](https://www.kaggle.com/datasets/tsiaras/uk-road-safety-accidents-and-vehicles) (Kaggle), 2005–2017:

- `Accident_Information`: ~2 million accidents
- `Vehicle_Information`: ~2.2 million vehicle records

The two tables are joined on `Accident_Index`. Only a subset of the columns is used (see `sql/01_schema.sql`). The CSVs are not included in this repository.

## What I did

1. **Schema and load**: two tables, all columns `VARCHAR` so the CSV import never fails on dirty values
2. **Indexes** on the join key and the most common filter columns
3. **Server tuning**: `shared_buffers` 128MB → 512MB and `max_parallel_workers_per_gather` → 4
4. **Range partitioning** of `Accident_Information` by `Year` (2005–08, 2009–12, 2013–17, default)

I checked each step with `EXPLAIN ANALYZE`.

## Results

**Indexes**: a 5-query join workload went from **20.6 s to 14.9 s** (−28%).

**Main benchmark query**: urban accidents before 2010 involving drivers aged 26–35 (join + aggregation):

| Step | Execution time | vs baseline | What the plan shows |
|---|---|---|---|
| Baseline (default settings) | 1,553 ms | – | Parallel Seq Scan on both tables, 2 workers |
| `shared_buffers = 512MB` | 743 ms | −52% | Far more buffer hits, fewer disk reads |
| + `max_parallel_workers_per_gather = 4` | 668 ms | −57% | 3 workers planned and launched |

**Partitioning**: on a more selective query (rural accidents in 2010, drivers aged 26–35), the planner scanned only the `acc_2009_2012` partition with an index scan (**partition pruning**). The query ran in 504 ms. This is a different query, so its time can't be compared with the table above.

Execution plans: [baseline](images/1-baseline.png) · [shared_buffers](images/2-shared-buffers.png) · [parallel workers](images/3-parallel-workers.png) · [partitioning](images/4-partitioning.png)

## Notes on methodology

- Each timing comes from a single run. A run on a cold cache is always slower, so part of the drop after the memory step is probably caching. Next time I would repeat every measurement 3–5 times and report the median.
- `ALTER SYSTEM` only writes the configuration file. `max_parallel_workers_per_gather` applies after `SELECT pg_reload_conf();`. `shared_buffers` applies only after a server restart, so it's worth checking with `SHOW shared_buffers;`.
- `Year` and `Date` are stored as `VARCHAR`. Proper `INTEGER`/`DATE` types would make range filters and partition bounds more robust.
- Measuring every optimization on the same query isolates the effect of each one.

## Repository structure

```
sql/
  01_schema.sql            tables and data load
  02_indexes.sql           indexes
  03_benchmark_queries.sql benchmark workload
  04_server_tuning.sql     shared_buffers and parallel workers
  05_partitioning.sql      range partitioning by year
  06_analysis_queries.sql  analysis queries and EXPLAIN ANALYZE
images/                    execution plans for each step
```

## How to run

1. Create a database in PostgreSQL.
2. Run `sql/01_schema.sql` and load the CSVs with `\copy` (commands inside the file).
3. Run the remaining scripts in order. Time `03_benchmark_queries.sql` before and after `02_indexes.sql`, and run the queries in `06_analysis_queries.sql` after each step.

---

Author: [Odysseas Tamvakos](https://www.linkedin.com/in/odysseas-tamvakos-044514281/)
