-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : User_Behaviour
-- Query    : Month of Year Seasonality
-- Objective: Analyze seasonal patterns in UPI transactions across months of the year
-- Key Insights : February highest volume (430.3 Mn avg daily)
--            May lowest volume (326.6 Mn) — summer slump indicator
--            October-November festival season bump visible
--            December year-end surge (405 Mn)
--            ~24% volume gap between summer trough (May) and peak (February)
--            Overall W-shaped seasonal pattern observed across the year
-- NOTE     : Unequal sample sizes; averages used for normalization
-- ============================================

SELECT 
    DATENAME(MONTH, Date) AS Month_Name,
    MONTH(Date) AS Month_Num,
    COUNT(*) AS Total_Days,
    ROUND(AVG(Volume_Mn), 2) AS Avg_Daily_Volume_Mn,
    ROUND(AVG(Value_Cr), 2) AS Avg_Daily_Value_Cr
FROM dbo.Daily_Statistics
GROUP BY DATENAME(MONTH, Date), MONTH(Date)
ORDER BY Month_Num;
