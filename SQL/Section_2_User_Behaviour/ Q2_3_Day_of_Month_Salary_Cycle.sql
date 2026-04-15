-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : User_Behaviour
-- Query    : Day of Month Salary Cycle
--Objective : Analyze UPI transaction patterns across days of the month 
--            to identify salary-driven behavior
-- Key Insights: Three-phase salary cycle confirmed:
--            FLUSH  Days 1-10  — Ticket ₹1,600-1,772 (rent, EMIs, investments)
--            DRIFT  Days 11-26 — Steady decline to ₹1,405 (retail spending)
--            RECOVERY Days 28-31 — Jumps back to ₹1,644-1,708 (advance salary)
--            Day 1 ticket ₹1,772 vs Day 26 ₹1,405 — 21% peak-to-trough drop
-- ============================================

SELECT 
    Day_of_Month,
    COUNT(*) AS Occurrences,
    ROUND(AVG(Volume_Mn), 2) AS Avg_Volume_Mn,
    ROUND(AVG(Value_Cr), 2) AS Avg_Value_Cr,
    ROUND(AVG(Avg_Transaction_Value_Rs), 2) AS Avg_Ticket_Size_Rs
FROM dbo.Daily_Statistics
GROUP BY Day_of_Month
ORDER BY Day_of_Month;
