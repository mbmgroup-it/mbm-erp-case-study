```sql
UPDATE  suadmin_erp.hr_monthly_salary  join hr_as_basic_info habi on hr_monthly_salary.as_id=habi.associate_id 
set hr_monthly_salary.sub_section_id = habi.as_subsection_id
where hr_monthly_salary.as_id IN ()
```
