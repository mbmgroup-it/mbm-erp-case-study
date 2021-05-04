```sql
select count(*) as c, sum(amount) as am from suadmin_erp.hr_salary_adjust_details as d 
left join suadmin_erp.hr_salary_adjust_master as m on m.id = d.salary_adjust_master_id 
left join suadmin_erp.hr_as_basic_info as b on b.associate_id = m.associate_id 
where d.type = 3 and d.date = '2021-04-26' and as_location in (6,8,10,12,13,14)
```
