```sql
select b.associate_id, max(in_date) from suadmin_erp.hr_attendance_ceil as a
left join suadmin_erp.hr_as_basic_info as b on a.as_id = b.as_id 
where as_unit_id = 2 and as_status in (2,5)
and in_date >= '2021-04-01' 
group by b.associate_id 
```
