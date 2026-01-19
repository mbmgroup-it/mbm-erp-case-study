SELECT
	po.reference_no,
	r.reference_no as req_no,
	pr.reference_no as parent_req_no
FROM
	pms.purchase_orders AS po
LEFT JOIN pms.quotations q on
	q.id = po.quotation_id
LEFT JOIN pms.request_proposals rp on
	rp.id = q.request_proposal_id
LEFT JOIN pms.request_proposal_requisitions rpr on
	rpr.request_proposal_id = rp.id
LEFT JOIN pms.requisitions r on
	r.id = rpr.requisition_id
LEFT JOIN pms.requisitions pr on
	pr.id = r.parent_id
	-- WHERE po.reference_no = 'PO-26-CEW-2-14808'
WHERE r.parent_id IS NOT NULL
ORDER BY po.id DESC
