-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : User_Behaviour
-- Query    : Day of Week Pattern
-- Objective: Analyze UPI usage patterns across days of the week
-- Key Insights : Weekend volume remains stable, but transaction value declines significantly
--            Saturday highest volume (379.3 Mn) — not Sunday as hypothesised
--            Sunday lowest volume (370.6 Mn) AND lowest ticket (₹1,245)
--            Monday highest ticket size (₹1,653) — B2B and P2P settlements
--            33% ticket gap between Monday (₹1,653) and Sunday (₹1,245)
--            Volume nearly flat Mon-Sat — UPI habit fully formed
--            Character of transactions changes; frequency does not
-- ============================================

SELECT 
    Day_of_Week,
    COUNT(*) AS Total_Days,
    ROUND(AVG(Volume_Mn), 2) AS Avg_Volume_Mn,
    ROUND(AVG(Value_Cr), 2) AS Avg_Value_Cr,
    ROUND(AVG(Avg_Transaction_Value_Rs), 2) AS Avg_Ticket_Size_Rs
FROM dbo.Daily_Statistics
GROUP BY Day_of_Week
ORDER BY 
    CASE Day_of_Week
        WHEN 'Monday'    THEN 1
        WHEN 'Tuesday'   THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday'  THEN 4
        WHEN 'Friday'    THEN 5
        WHEN 'Saturday'  THEN 6
        WHEN 'Sunday'    THEN 7
    END;
