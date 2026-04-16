-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : User_Behaviour
-- Query    : Weekend vs Weekday Split
-- Objective: Compare UPI usage between weekdays and weekends
-- Findings : Volume virtually identical — Weekday 375.9 Mn vs Weekend 374.9 Mn (0.3% gap)
--            Value gap significant — Weekday ₹56,924 Cr vs Weekend ₹48,760 Cr (14.3% gap)
--            Ticket size gap — Weekday ₹1,610 vs Weekend ₹1,375 (17% premium)
--            Headline: UPI usage frequency remains constant, 
--            but transaction purpose shifts between weekdays and weekends
-- ============================================

SELECT 
    Is_Weekend,
    COUNT(*) AS Total_Days,
    ROUND(AVG(Volume_Mn), 2) AS Avg_Volume_Mn,
    ROUND(AVG(Value_Cr), 2) AS Avg_Value_Cr,
    ROUND(AVG(Avg_Transaction_Value_Rs), 2) AS Avg_Ticket_Size_Rs,
    ROUND(MAX(Volume_Mn), 2) AS Peak_Volume_Mn,
    ROUND(MIN(Volume_Mn), 2) AS Lowest_Volume_Mn
FROM dbo.Daily_Statistics
GROUP BY Is_Weekend;
