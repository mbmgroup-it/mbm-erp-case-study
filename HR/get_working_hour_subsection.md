```sql
select a.in_date, s.hr_subsec_name , count(*) as employee, 
round(sum((TIMESTAMPDIFF(MINUTE,a.in_time , a.out_time ) - 30)/60),2) as hours 
from suadmin_erp.hr_attendance_ceil as a 
left join suadmin_erp.hr_as_basic_info as b on a.as_id = b.as_id 
left join suadmin_erp.hr_subsection as s on s.hr_subsec_id = b.as_subsection_id 
where b.as_subsection_id in (137,138,139,188) and a.in_date >= '2021-03-01' and a.in_date <= '2021-03-31' 
group by a.in_date,b.as_subsection_id 
```
