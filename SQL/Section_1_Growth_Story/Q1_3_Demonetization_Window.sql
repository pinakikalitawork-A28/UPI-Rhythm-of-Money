-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : Growth Story
-- Query    : Demonetization Window 
-- Objective: Analyze the impact of demonetization on early UPI adoption
-- Key Insights : Nov 2016 (demonetization) volume jumped +190% MoM
--            Dec 2016 surged further +586% MoM — largest single-month jump ever
--            Jan 2017 continued +124% MoM — forced adoption sustained
--            Ticket size crashed from ₹4,857 to ₹917 as mass users joined
-- ============================================

WITH Base AS (
    SELECT 
        Month,
        Volume_Mn,
        Value_Cr,
        Avg_Transaction_Value_Rs,
        Banks_On_UPI,
        LAG(Volume_Mn) OVER (ORDER BY Month) AS Prev_Month_Volume
    FROM dbo.UPI_Monthly
    WHERE Month BETWEEN '2016-01-07' AND '2017-01-12'
)
SELECT 
    Month,
    Banks_On_UPI,
    Volume_Mn,
    Value_Cr,
    Avg_Transaction_Value_Rs,
    Prev_Month_Volume,
    CAST(ROUND((Volume_Mn - Prev_Month_Volume) / NULLIF(Prev_Month_Volume, 0) * 100, 1) AS DECIMAL(8,1)) AS MoM_Growth_Pct
FROM Base
ORDER BY Month;
