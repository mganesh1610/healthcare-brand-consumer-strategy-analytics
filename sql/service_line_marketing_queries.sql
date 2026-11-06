-- =============================================================================
-- Healthcare Service-Line Brand, Consumer Acquisition & Sponsorship Analytics
-- Dialect: Standard SQL (SQL Joins & CTEs)
-- =============================================================================

WITH service_line_access_readiness AS (
    SELECT
        sl.service_line_id,
        sl.service_line_name,
        sl.program_tier,
        sl.annual_marketing_budget_usd,
        ops.median_wait_days,
        ops.slot_utilization_pct,
        ops.market_share_pct,
        CASE
            WHEN ops.median_wait_days > 14.0 OR ops.slot_utilization_pct > 92.0
                THEN 'PIVOT_TO_ACCESS_READY_DIGITAL'
            ELSE 'SCALE_ACQUISITION_CAMPAIGNS'
        END AS operational_readiness_status
    FROM dim_service_lines AS sl
    INNER JOIN fact_clinic_operational_capacity AS ops
        ON sl.service_line_id = ops.service_line_id
),
multichannel_campaign_rollup AS (
    SELECT
        c.service_line_id,
        c.channel_name,
        SUM(c.spend_usd) AS total_spend_usd,
        SUM(c.impressions) AS total_impressions,
        SUM(c.clicks) AS total_clicks,
        SUM(c.new_patient_appointments) AS new_patients_acquired,
        SUM(c.retained_patient_visits) AS retained_patients,
        SUM(c.attributed_revenue_usd) / NULLIF(SUM(c.spend_usd), 0) AS channel_roas,
        SUM(c.spend_usd) / NULLIF(SUM(c.new_patient_appointments), 0) AS patient_cac_usd
    FROM fact_multichannel_campaigns AS c
    GROUP BY c.service_line_id, c.channel_name
),
mystery_shopping_experience AS (
    SELECT
        m.service_line_id,
        COUNT(m.audit_id) AS mystery_shop_audits,
        AVG(m.pre_remediation_csat_pct) AS pre_csat_pct,
        AVG(m.post_remediation_csat_pct) AS post_csat_pct,
        AVG(m.post_remediation_csat_pct - m.pre_remediation_csat_pct) AS csat_lift_pts
    FROM fact_mystery_shopping_audits AS m
    GROUP BY m.service_line_id
)
SELECT
    r.service_line_name,
    r.program_tier,
    r.operational_readiness_status,
    r.market_share_pct,
    mc.channel_name,
    mc.total_spend_usd,
    mc.new_patients_acquired,
    mc.retained_patients,
    ROUND(mc.channel_roas, 2) AS channel_roas,
    ROUND(mc.patient_cac_usd, 2) AS patient_cac_usd,
    ms.mystery_shop_audits,
    ROUND(ms.csat_lift_pts, 2) AS mystery_shop_csat_lift_pts
FROM service_line_access_readiness AS r
LEFT JOIN multichannel_campaign_rollup AS mc
    ON r.service_line_id = mc.service_line_id
LEFT JOIN mystery_shopping_experience AS ms
    ON r.service_line_id = ms.service_line_id
ORDER BY r.annual_marketing_budget_usd DESC, mc.total_spend_usd DESC;
