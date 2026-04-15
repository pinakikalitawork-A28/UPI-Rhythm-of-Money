-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : Growth Story
-- Query    : Full Growth Timeline
-- Objective : Analyse how UPI eveolved from launch to mass adoption
-- Key Insights : UPI grew from 0.09 Mn (Aug 2016) to 21,703 Mn (Jan 2026)
--            Cumulative total of 706,864 Mn transactions
--            Banks on network grew from 21 to 694
-- ============================================

SELECT 
    Month,
    Volume_Mn,
    Value_Cr,
    Avg_Transaction_Value_Rs,
    Banks_On_UPI,
    SUM(Volume_Mn) OVER (ORDER BY Month) AS Cumulative_Volume_Mn
FROM dbo.UPI_Monthly
ORDER BY Month;
