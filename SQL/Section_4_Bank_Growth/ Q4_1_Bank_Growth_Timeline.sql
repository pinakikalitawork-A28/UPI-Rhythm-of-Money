-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : Bank Growth
-- Query    : Bank Growth Timeline
-- Objective: Analyze how UPI network expansion (banks) influenced transaction growth
-- Findings : Banks grew from 21 (Aug 2016) to 694 (Feb 2026) — 33x growth
--            Volume per bank grew from 0.01 Mn to 29.4 Mn — 2,900x growth
--            Both lines rise together = genuine network effect
--            Oct 2022: volume per bank first crossed 20 Mn (mainstream moment)
--            Network effect: each new bank brings exponentially more transactions
-- ============================================

SELECT 
    Month,
    Banks_On_UPI,
    Volume_Mn,
    ROUND(Volume_Mn / Banks_On_UPI, 2) AS Avg_Volume_Per_Bank_Mn
FROM dbo.UPI_Monthly
WHERE Banks_On_UPI > 0
ORDER BY Month;
