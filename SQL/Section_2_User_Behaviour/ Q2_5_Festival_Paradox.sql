
-- ============================================
-- Project  : UPI Rhythm of Money 2016-2026
-- Section  : User_Behaviour
-- Query    : Festival Paradox 
-- Objective: Analyze UPI transaction behavior across major festivals
--Key Insights : Volume declines slightly on festival days across all festivals
--               Ticket size drops more sharply, indicating shift to smaller payments
--               Pattern consistent across Diwali, Holi, Eid and Christmas
--               Post-festival recovery seen in ticket size and value
--               UPI usage continues, but shifts from high-value to small transactions
-- ============================================

WITH Festival_Base AS (
    SELECT 
        Date,
        Volume_Mn,
        Value_Cr,
        Avg_Transaction_Value_Rs,

        -- Festival Name (includes Before + Festival + After)
        CASE 
            -- Diwali
            WHEN Date IN (
                '2021-11-03','2021-11-04','2021-11-05',
                '2022-10-23','2022-10-24','2022-10-25',
                '2023-11-11','2023-11-12','2023-11-13',
                '2024-10-31','2024-11-01','2024-11-02'
            ) THEN 'Diwali'

            -- Holi
            WHEN Date IN (
                '2021-03-28','2021-03-29','2021-03-30',
                '2022-03-17','2022-03-18','2022-03-19',
                '2023-03-07','2023-03-08','2023-03-09',
                '2024-03-24','2024-03-25','2024-03-26'
            ) THEN 'Holi'

            -- Eid
            WHEN Date IN (
                '2021-05-12','2021-05-13','2021-05-14',
                '2022-05-02','2022-05-03','2022-05-04',
                '2023-04-21','2023-04-22','2023-04-23',
                '2024-04-10','2024-04-11','2024-04-12'
            ) THEN 'Eid'

            -- Christmas
            WHEN Date IN (
                '2021-12-24','2021-12-25','2021-12-26',
                '2022-12-24','2022-12-25','2022-12-26',
                '2023-12-24','2023-12-25','2023-12-26',
                '2024-12-24','2024-12-25','2024-12-26'
            ) THEN 'Christmas'
        END AS Festival_Name,

        -- Period Classification
        CASE 
            -- Festival Day
            WHEN Date IN (
                '2021-11-04','2022-10-24','2023-11-12','2024-11-01',
                '2021-03-29','2022-03-18','2023-03-08','2024-03-25',
                '2021-05-13','2022-05-03','2023-04-22','2024-04-11',
                '2021-12-25','2022-12-25','2023-12-25','2024-12-25'
            ) THEN 'Festival Day'

            -- Before
            WHEN Date IN (
                '2021-11-03','2022-10-23','2023-11-11','2024-10-31',
                '2021-03-28','2022-03-17','2023-03-07','2024-03-24',
                '2021-05-12','2022-05-02','2023-04-21','2024-04-10',
                '2021-12-24','2022-12-24','2023-12-24','2024-12-24'
            ) THEN 'Before'

            -- After
            WHEN Date IN (
                '2021-11-05','2022-10-25','2023-11-13','2024-11-02',
                '2021-03-30','2022-03-19','2023-03-09','2024-03-26',
                '2021-05-14','2022-05-04','2023-04-23','2024-04-12',
                '2021-12-26','2022-12-26','2023-12-26','2024-12-26'
            ) THEN 'After'
        END AS Period

    FROM dbo.Daily_Statistics
)

SELECT 
    Festival_Name,
    Period,
    COUNT(*) AS Total_Days,
    ROUND(AVG(Volume_Mn), 2) AS Avg_Volume_Mn,
    ROUND(AVG(Value_Cr), 2) AS Avg_Value_Cr,
    ROUND(AVG(Avg_Transaction_Value_Rs), 2) AS Avg_Ticket_Size_Rs
FROM Festival_Base
WHERE Festival_Name IS NOT NULL
GROUP BY Festival_Name, Period
ORDER BY Festival_Name,
    CASE Period 
        WHEN 'Before' THEN 1
        WHEN 'Festival Day' THEN 2
        WHEN 'After' THEN 3
    END;
