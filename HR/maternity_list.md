```sql
  select b.associate_id, b.as_name, b.as_oracle_code, d.hr_designation_name, b.as_status_date 
  from suadmin_erp.hr_as_basic_info as b 
  left join suadmin_erp.hr_designation as d on b.as_designation_id = d.hr_designation_id 
  where b.as_status = 6 and b.as_unit_id in (1,4,5)
```
