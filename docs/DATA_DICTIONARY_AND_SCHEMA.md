# Data Dictionary & Schema Documentation

## 1. Public Datasets & Provenance

1. **Primary Dataset 1 — CMS Hospital Consumer Assessment of Healthcare Providers and Systems (HCAHPS) & Provider Data Catalog** (`4,800` U.S. hospital facility & service-line consumer experience records):
   - Direct Link: https://data.cms.gov/provider-data/topics/hospitals
   - Scope: Patient experience star ratings, willingness-to-recommend, care transition communication, and facility quality benchmarks.
2. **Primary Dataset 2 — Kevin Hillstrom MineThatData Multi-Channel Consumer Marketing Dataset** (`64,000` consumer campaign & retention records):
   - Direct Link: http://www.minethatdata.com/Kevin_Hillstrom_MineThatData_E-MailAnalytics_DataMiningChallenge_2008.03.20.csv
   - Scope: Randomized multi-channel marketing outreach, visit conversion, retention history, and channel spend attribution.
3. **Backup Dataset — UCI Bank Marketing Consumer Campaign Dataset** (`45,211` records):
   - Direct Link: https://archive.ics.uci.edu/static/public/222/bank+marketing.zip

## 2. Core Analytical Tables

| Table Name | Grain | Key Columns |
| :--- | :--- | :--- |
| `dim_service_lines` | `1 row per medical service line` | `service_line_id`, `service_line_name`, `program_tier`, `annual_marketing_budget_usd`, `contribution_margin_per_patient_usd` |
| `fact_clinic_operational_capacity` | `service_line_id x week` | `median_wait_days`, `slot_utilization_pct`, `market_share_pct`, `access_readiness_gate` |
| `fact_multichannel_campaigns` | `campaign_id x channel x date` | `channel_name`, `spend_usd`, `impressions`, `clicks`, `new_patient_appointments`, `retained_patient_visits`, `attributed_revenue_usd` |
| `fact_mystery_shopping_audits` | `audit_id x touchpoint` | `consumer_touchpoint`, `pre_remediation_csat_pct`, `post_remediation_csat_pct`, `retention_or_booking_lift_pct` |
| `fact_sports_sponsorship_activations` | `activation_id x partnership_tier` | `partnership_tier`, `activations_count`, `annual_spend_usd`, `impressions`, `attributed_new_patients`, `sponsorship_roas`, `brand_recall_lift_pct` |
