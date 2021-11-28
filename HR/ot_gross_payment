SELECT d.date, COUNT(*), SUM(amount) FROM suadmin_erp.hr_salary_adjust_details as d
left join hr_salary_adjust_master hsam on d.salary_adjust_master_id = hsam.id 
left join hr_as_basic_info habi on hsam.associate_id = habi.associate_id 
WHERE d.`type` = 2 AND habi.as_unit_id IN (1,4,5) GROUP BY d.`date` ORDER BY d.`date` ASC 
