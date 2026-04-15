-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : Ticket_Size_Analysis
-- Query    : Monthly Ticket Size Decline Curve
-- Objective: Analyze the trend and phases of UPI ticket size decline over time
-- Key Insights : May 2021 avg ticket ₹1,920 → Feb 2026 ₹1,314 (-32% in 58 months)
--            Two distinct phases:
--            Phase 1 May 2021 - mid 2023: Steep decline (-₹420 in 2 years)
--            Phase 2 mid 2023 - Feb 2026: Flattening — possible structural floor
--            Aug 2025 all-time low: ₹1,239 (coincides with 20 Bn monthly milestone)
--            Monthly volume grew 8x over same period (2,540 to 20,394 Mn)
--            Strong inverse relationship: higher transaction volume corresponds to lower average ticket size
-- ============================================

SELECT 
    Month_Year,
    MIN(Date) AS Period_Start,
    COUNT(*) AS Days_In_Period,
    ROUND(SUM(Volume_Mn), 2) AS Total_Volume_Mn,
    ROUND(SUM(Value_Cr), 2) AS Total_Value_Cr,
    ROUND(AVG(Avg_Transaction_Value_Rs), 2) AS Avg_Ticket_Size_Rs
FROM dbo.Daily_Statistics
GROUP BY Month_Year
ORDER BY MIN(Date);
