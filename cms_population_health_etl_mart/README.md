# CDC PLACES Community Preventive Care-Gap, SQL Server (`T-SQL` / `SSIS`) & Power BI / SSRS Warehouse Mart

`P1` data-engineering module extending `healthcare-brand-consumer-strategy-analytics` with a normalized **SQL Server (`T-SQL`, `SSIS`)** star schema (`dim_geography`, `dim_health_measure`, `fct_population_care_gaps`), **10/10 (`100%`)** deterministic SQL data-quality and confidence-interval parity gates, and **Power BI (`DAX`)** / **SSRS** regional preventive outreach worklists across **50,000 SHA-256 verified CDC PLACES records** (`648` county/geographic entities, `40` preventive screening & chronic disease measures across `14` states).

## Verified Execution Summary

- **Primary Public Source:** CDC PLACES Local Data for Better Health (`https://data.cdc.gov/resource/swc5-untb.json?$limit=50000&$order=:id`, SHA-256 `061da90d3ddd39b33d0c11cee92da17ece4378b78d7c9f660f70528b7c1e5261`).
- **Backup Public Sources:** CMS Provider Data Catalog — Hospital Timely & Effective Care (`https://data.cms.gov/provider-data/topics/hospitals`) and HRSA Uniform Data System (`https://data.hrsa.gov/topics/health-centers`).
- **Scale & Quality:** `50,000` validated observations (`0` confidence-interval inversions, `0` foreign-key violations, `10/10` SQL DQ gates passed).
- **Outputs:** `outputs/powerbi_state_category_care_gaps.csv`, `outputs/ssrs_top50_priority_outreach_counties.csv`, `outputs/dq_10_gates_report.json`.

## Quickstart

```bash
python3 cms_population_health_etl_mart/population_health_etl.py
python3 -m unittest discover -s cms_population_health_etl_mart/tests -v
```
