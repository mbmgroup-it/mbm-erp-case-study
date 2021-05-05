```sql
select * from  suadmin_erp.hr_attendance_ceil  
where TIMESTAMPDIFF(MINUTE,in_time ,out_time) < 200 and in_time is not null and out_time is not null
```
