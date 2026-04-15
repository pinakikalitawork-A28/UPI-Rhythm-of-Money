-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : Ticket_Size_Analysis
-- Query    : UPI Transaction Size Segmentation
-- Objective: Analyze how UPI transactions shifted across ticket size segments over time
-- Key Insights : High-value (₹2000+) transactions disappeared after Apr 2023
--               Sub-₹1000 (micro payments) emerged from Aug 2023
--               Clear shift from high-value to low-value transaction dominance
--               Micro days show highest activity (~589 Mn avg volume)
--               High-value days show lowest activity (~140 Mn avg volume)
--               Headline: UPI has transitioned from high-value transfers to everyday small payments
-- ============================================

SELECT 
    CASE 
        WHEN Avg_Transaction_Value_Rs >= 2000 THEN 'High Value (₹2000+)'
        WHEN Avg_Transaction_Value_Rs BETWEEN 1500 AND 1999 THEN 'Mid Value (₹1500-1999)'
        WHEN Avg_Transaction_Value_Rs BETWEEN 1000 AND 1499 THEN 'Low Value (₹1000-1499)'
        ELSE 'Micro (Below ₹1000)'
    END AS Ticket_Bucket,
    COUNT(*) AS Days_Count,
    MIN(Date) AS Earliest_Date,
    MAX(Date) AS Latest_Date,
    ROUND(AVG(Volume_Mn), 2) AS Avg_Volume_Mn
FROM dbo.Daily_Statistics
GROUP BY 
    CASE 
        WHEN Avg_Transaction_Value_Rs >= 2000 THEN 'High Value (₹2000+)'
        WHEN Avg_Transaction_Value_Rs BETWEEN 1500 AND 1999 THEN 'Mid Value (₹1500-1999)'
        WHEN Avg_Transaction_Value_Rs BETWEEN 1000 AND 1499 THEN 'Low Value (₹1000-1499)'
        ELSE 'Micro (Below ₹1000)'
    END
ORDER BY MIN(Avg_Transaction_Value_Rs) DESC;
