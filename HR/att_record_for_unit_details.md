```sql
select b.associate_id as 'Associate ID', b.as_name as 'Name', b.as_oracle_code as 'Oracle ID',
d.hr_designation_name as 'Designation',
dp.hr_department_name as 'Department',
s.hr_section_name as 'Section',
sb.hr_subsec_name as 'Subsction', 
f.hr_floor_name as 'Floor',l.hr_line_name AS 'Line',
b.as_doj AS 'DOJ', 
CASE when as_ot = 0 THEN 'Non OT' when as_ot = 1 THEN 'OT' END AS OT,
a.in_date AS 'Date', a.in_time AS 'In Time', a.out_time as 'Out Time'
from suadmin_erp.hr_attendance_aql as a 
left join suadmin_erp.hr_as_basic_info as b on a.as_id = b.as_id 
left join suadmin_erp.hr_department as dp on b.as_department_id = dp.hr_department_id
left join suadmin_erp.hr_designation as d on b.as_designation_id = d.hr_designation_id
left join suadmin_erp.hr_section as s on b.as_section_id = s.hr_section_id
left join suadmin_erp.hr_subsection as sb on b.as_subsection_id = sb.hr_subsec_id
left join suadmin_erp.hr_floor as f on b.as_floor_id = f.hr_floor_id
left join suadmin_erp.hr_line as l on b.as_line_id = l.hr_line_id
where a.in_date >= '2021-04-15' and a.in_date <= '2021-04-30' and a.created_at < '2021-05-02 16:00:00' and b.as_status = 1
```
