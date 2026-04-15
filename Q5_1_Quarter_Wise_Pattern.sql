-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : Seasonality
-- Query    : Quarter-Wise Pattern
-- Objective: Analyze seasonal variation in UPI transactions across fiscal quarters
-- Findings : Q4 (Jan-Mar) highest volume: 404.9 Mn avg daily — year-end finance rush
--            Q3 (Oct-Dec) second highest: 395.0 Mn — festival season
--            Q1 (Apr-Jun) lowest: 344.8 Mn — summer slump
--            Q2 (Jul-Sep) lowest ticket: ₹1,524 — monsoon micro-spending
--            15% volume gap between Q1 (summer) and Q4 (year-end)
--            Q4 beats Q3 due to invisible festival of Indian personal finance:
--            tax payments, advance tax, insurance renewals, mutual fund SIPs
-- ============================================

SELECT 
    CASE 
        WHEN MONTH(Date) IN (4,5,6)    THEN 'Q1 (Apr-Jun)'
        WHEN MONTH(Date) IN (7,8,9)    THEN 'Q2 (Jul-Sep)'
        WHEN MONTH(Date) IN (10,11,12) THEN 'Q3 (Oct-Dec)'
        ELSE                                'Q4 (Jan-Mar)'
    END AS Fiscal_Quarter,
    COUNT(*) AS Total_Days,
    ROUND(AVG(Volume_Mn), 2) AS Avg_Daily_Volume_Mn,
    ROUND(AVG(Value_Cr), 2) AS Avg_Daily_Value_Cr,
    ROUND(AVG(Avg_Transaction_Value_Rs), 2) AS Avg_Ticket_Size_Rs
FROM dbo.Daily_Statistics
GROUP BY 
    CASE 
        WHEN MONTH(Date) IN (4,5,6)    THEN 'Q1 (Apr-Jun)'
        WHEN MONTH(Date) IN (7,8,9)    THEN 'Q2 (Jul-Sep)'
        WHEN MONTH(Date) IN (10,11,12) THEN 'Q3 (Oct-Dec)'
        ELSE                                'Q4 (Jan-Mar)'
    END
ORDER BY MIN(Date);
