SELECT
    r.production_date,
    r.hr_floor_name,
    SUM(r.plan_target) AS target
FROM (
    SELECT DISTINCT
        pt.id,
        pt.production_date,
        hf.hr_floor_name,
        pt.plan_target
    FROM
        cuttingedgedb.pt_sewing_daily_line_targets AS pt
    LEFT JOIN daily_productions dp
        ON dp.pt_daily_line_target_id = pt.id
    LEFT JOIN hr_floor hf
        ON hf.hr_floor_id = pt.hr_floor_id
    WHERE
        pt.hr_line_id IN (
            441, 450, 451, 452, 453, 462, 463, 464, 454, 455,
            456, 442, 457, 458, 459, 460, 461, 475, 474, 465,
            470, 471, 443, 472, 473, 466, 467, 468, 469, 570,
            571, 634, 635, 444, 636, 637, 638, 647, 445, 446,
            447, 448, 449
        )
        AND dp.hr_unit_id = 2
        AND dp.prod_date >= '2025-05-01'
        AND dp.id IS NOT NULL
) AS r
GROUP BY r.production_date, r.hr_floor_name