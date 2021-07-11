```sql
SELECT 
a.in_date, 
s.hr_section_name as 'Section',
count(*) as 'Employee', 
sum(a.ot_hour) as 'Total OT', 
max(a.ot_hour) as 'Max' 
from hr_attendance_ceil as a 
left join hr_as_basic_info as b on b.as_id = a.as_id 
left join hr_section as s on b.as_section_id = s.hr_section_id 
where in_date >= '2021-01-01' 
and b.as_section_id in (124,126,127) 
and (b.as_ot = 1 OR a.ot_hour > 0) 
group by a.in_date,b.as_section_id
```
