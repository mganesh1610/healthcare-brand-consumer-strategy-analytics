-- =============================================================================
-- Population Health & Preventive Care-Gap Star Schema (SQL Server T-SQL, SSIS, SSRS & Power BI)
-- =============================================================================

CREATE OR ALTER VIEW dbo.vw_PowerBI_Population_CareGap_Star AS
SELECT
    g.location_id,
    g.state_abbr,
    g.state_desc,
    g.county_name,
    g.total_population,
    m.category_id,
    m.category AS measure_category,
    m.measure_id,
    m.measure_name,
    f.year,
    f.reported_pct,
    f.low_ci_pct,
    f.high_ci_pct,
    f.standardized_care_gap_pct,
    CAST(ROUND(g.total_population * (f.standardized_care_gap_pct / 100.0), 0) AS BIGINT) AS estimated_affected_residents
FROM dbo.fct_population_care_gaps f
INNER JOIN dbo.dim_geography g ON g.location_id = f.location_id
INNER JOIN dbo.dim_health_measure m ON m.measure_id = f.measure_id
WHERE f.data_value_type_id = 'CrdPrv';
GO

-- SSRS Parameterized Stored Procedure for Regional Preventive Outreach Teams
CREATE OR ALTER PROCEDURE dbo.usp_SSRS_GetRegionalCareGaps
    @StateAbbr CHAR(2),
    @MinCareGapPct DECIMAL(5,2) = 25.00
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        county_name,
        measure_category,
        measure_name,
        standardized_care_gap_pct,
        low_ci_pct,
        high_ci_pct,
        estimated_affected_residents
    FROM dbo.vw_PowerBI_Population_CareGap_Star
    WHERE state_abbr = @StateAbbr
      AND standardized_care_gap_pct >= @MinCareGapPct
    ORDER BY estimated_affected_residents DESC, standardized_care_gap_pct DESC;
END;
GO
