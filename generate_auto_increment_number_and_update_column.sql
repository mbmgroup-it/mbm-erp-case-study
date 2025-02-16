SELECT emoed.* FROM mbmcomm.export_master_only_exfty_date_2025 AS emoed
WHERE ex_factory_date >= '2024-01-01' and buyer_id = 44
ORDER BY ex_factory_date ASC

UPDATE
	mbmcomm.export_master_only_exfty_date_2025 emoed
JOIN (
	SELECT
		id,
		CONCAT('25GS', LPAD(ROW_NUMBER() OVER (ORDER BY ex_factory_date ASC), 4, '0')) AS new_gs_invoice_no
	FROM
		mbmcomm.export_master_only_exfty_date_2025
	WHERE
		ex_factory_date >= '2024-01-01'
		AND buyer_id = 44
) RankedData
ON
	emoed.id = RankedData.id
SET
	emoed.gs_invoice_no = RankedData.new_gs_invoice_no;
