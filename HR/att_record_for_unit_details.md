```sql
select b.associate_id as 'Associate ID', b.as_name as 'Name', b.as_oracle_code as 'Oracle ID',
u.hr_unit_short_name as 'Unit',
loc.hr_location_name as 'Location',
d.hr_designation_name as 'Designation',
dp.hr_department_name as 'Department',
s.hr_section_name as 'Section',
sb.hr_subsec_name as 'Subsction', 
f.hr_floor_name as 'Floor',l.hr_line_name AS 'Line',
b.as_doj AS 'DOJ', 
CASE when as_ot = 0 THEN 'Non OT' when as_ot = 1 THEN 'OT' END AS OT,
CASE when as_status = 1 THEN 'Active' when as_status = 2 THEN 'Resign' when as_status = 5 THEN 'Left' when as_status = 6 THEN 'Maternity' END AS Status,
sft.hr_shift_name as 'Shift Name',
sft.hr_shift_start_time as 'Shift Start',
sft.hr_shift_end_time AS 'Shift End',
sft.hr_shift_break_time AS 'Shift Break',
a.in_date AS 'Date', a.in_time AS 'In Time', a.out_time as 'Out Time', a.ot_hour as 'OT'
from suadmin_erp.hr_attendance_mbm as a 
left join suadmin_erp.hr_as_basic_info as b on a.as_id = b.as_id 
left join suadmin_erp.hr_location as loc on b.as_location = loc.hr_location_id
left join suadmin_erp.hr_unit as u on b.as_unit_id = u.hr_unit_id
left join suadmin_erp.hr_department as dp on b.as_department_id = dp.hr_department_id
left join suadmin_erp.hr_designation as d on b.as_designation_id = d.hr_designation_id
left join suadmin_erp.hr_section as s on b.as_section_id = s.hr_section_id
left join suadmin_erp.hr_subsection as sb on b.as_subsection_id = sb.hr_subsec_id
left join suadmin_erp.hr_floor as f on b.as_floor_id = f.hr_floor_id
left join suadmin_erp.hr_line as l on b.as_line_id = l.hr_line_id
left join suadmin_erp.hr_shift as sft on a.hr_shift_code = sft.hr_shift_code
where a.in_date >= '2021-05-01' and a.in_date <= '2021-05-17'
```
