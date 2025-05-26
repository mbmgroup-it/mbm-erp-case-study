SELECT
	r.production_date,
	r.hr_floor_name,
	r.target
FROM
	(
	SELECT
		CONCAT_WS('|', pt.production_date, hf.hr_floor_id) as fd_key,
		pt.production_date,
		hf.hr_floor_name,
		SUM(pt.plan_target) as target
	FROM
		cuttingedgedb.pt_sewing_daily_line_targets AS pt
	LEFT JOIN daily_productions dp on
		dp.pt_daily_line_target_id = pt.id
	LEFT JOIN hr_line hl on
		hl.hr_line_id = pt.hr_line_id
	LEFT JOIN hr_floor hf on
		hf.hr_floor_id = pt.hr_floor_id
	WHERE
		pt.hr_line_id IN (441, 450, 451, 452, 453, 462, 463, 464, 454, 455, 456, 442, 457, 458, 459, 460, 461, 475, 474, 465, 470, 471, 443, 472, 473, 466, 467, 468, 469, 570, 571, 634, 635, 444, 636, 637, 638, 647, 445, 446, 447, 448, 449)
		and dp.hr_unit_id = 2
		and prod_date >= '2025-05-01'
	GROUP BY
		fd_key 
) as r

