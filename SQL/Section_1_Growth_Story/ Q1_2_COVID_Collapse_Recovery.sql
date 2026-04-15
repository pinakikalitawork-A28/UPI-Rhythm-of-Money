-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : Growth Story
-- Query    : COVID Collapse and Recovery
-- Objective: Analyze the impact of COVID-19 on UPI transaction trends
-- Key Insights : Apr 2020 volume fell -19.8% MoM to 999.57 Mn
--            Only sustained decline in UPI history
--            Full V-shaped recovery within 2 months (May +23.5%, Jun +8.3%)
--            By Oct 2020 volume doubled pre-COVID levels
-- ============================================

WITH Base AS (
    SELECT 
        Month,
        Volume_Mn,
        Value_Cr,
        Avg_Transaction_Value_Rs,
        LAG(Volume_Mn) OVER (ORDER BY Month) AS Prev_Month_Volume
    FROM dbo.UPI_Monthly
    WHERE Month BETWEEN '2019-10-01' AND '2022-06-01'
)
SELECT 
    Month,
    Volume_Mn,
    Value_Cr,
    Avg_Transaction_Value_Rs,
    Prev_Month_Volume,
    CAST(ROUND((Volume_Mn - Prev_Month_Volume) / Prev_Month_Volume * 100, 1) AS DECIMAL(8,1)) AS MoM_Growth_Pct
FROM Base
ORDER BY Month;
