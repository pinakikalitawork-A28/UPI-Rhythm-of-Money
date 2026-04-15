-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : Ticket_Size_Analysis
-- Query    : Annual Ticket Size Trend by Fiscal Year
-- Objective: Analyze how UPI ticket size has evolved over time
-- Key Insights :Ticket size declined from ₹2,648 (FY16) to ~₹1,310 (FY25) — ~50% drop
--               Sharp fall post demonetization (FY18) due to mass adoption
--               COVID caused temporary spike (FY21) as small payments dropped
--               Long-term trend shows structural shift toward smaller transactions
--               Growth driven by usage expansion, not higher ticket size
-- NOTE     : FY 2025-26 is partial year — treat with caution
-- ============================================

SELECT 
    CASE 
        WHEN MONTH(Month) >= 4 
        THEN CAST(YEAR(Month) AS VARCHAR) + '-' + RIGHT(CAST(YEAR(Month)+1 AS VARCHAR), 2)
        ELSE CAST(YEAR(Month)-1 AS VARCHAR) + '-' + RIGHT(CAST(YEAR(Month) AS VARCHAR), 2)
    END AS Fiscal_Year,
    ROUND(AVG(Avg_Transaction_Value_Rs), 2) AS Avg_Ticket_Size_Rs,
    ROUND(SUM(Volume_Mn), 2) AS Total_Volume_Mn,
    ROUND(SUM(Value_Cr), 2) AS Total_Value_Cr
FROM dbo.UPI_Monthly
WHERE Volume_Mn > 0
GROUP BY 
    CASE 
        WHEN MONTH(Month) >= 4 
        THEN CAST(YEAR(Month) AS VARCHAR) + '-' + RIGHT(CAST(YEAR(Month)+1 AS VARCHAR), 2)
        ELSE CAST(YEAR(Month)-1 AS VARCHAR) + '-' + RIGHT(CAST(YEAR(Month) AS VARCHAR), 2)
    END
ORDER BY MIN(Month);
