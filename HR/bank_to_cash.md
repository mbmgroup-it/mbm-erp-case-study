UPDATE `hr_monthly_salary` SET `salary_payable` =`salary_payable` - 10, `stamp` = 10, `pay_status` = 1,`total_payable`=`total_payable`-10, `cash_payable` = `total_payable`, `bank_payable`=0,`pay_type`=NULL WHERE month = '11' AND year = 2021 AND pay_status = 2 AND as_id IN ()