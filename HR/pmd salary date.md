```sql
select b.associate_id as 'Associate ID', b.as_name as 'Name', b.as_oracle_code as 'Oracle ID',
u.hr_unit_short_name as 'Unit',
loc.hr_location_name as 'Location',
d.hr_designation_name as 'Designation',
d.hr_designation_grade as 'Grade', 
dp.hr_department_name as 'Department',
s.hr_section_name as 'Section',
sb.hr_subsec_name as 'Subsction',
b.as_gender AS 'Gender', 
b.as_doj AS 'DOJ', 
eob.status_date AS 'DOL', 
et.hr_emp_type_name AS 'Type',
CASE when as_ot = 0 THEN 'Non OT' when as_ot = 1 THEN 'OT' END AS 'OT',
CASE when m.emp_status = 1 THEN 'Active' when m.emp_status = 6 THEN 'Maternity' when m.emp_status = 2 THEN 'Left'
when m.emp_status = 5 THEN 'Resign' END AS 'Status',
m.month as 'Month',
m.year as 'Year',
m.gross as 'Salary/Wages',
m.ot_hour as 'OT Hour',
round(m.ot_hour*m.ot_rate,2) as 'Compensation',
m.attendance_bonus  as 'Attendance Bonus',
m.total_payable as 'Total Amount',
m.present as 'Present',
m.`leave` as 'Leave', 
m.`absent` as 'Absent',
m.`holiday` as 'Holiday',
(m.present + m.absent + m.holiday + m.`leave`) as 'Working Day',
ml.sick as 'Sick',
ml.earned  as 'Earned',
ml.casual  as 'Casual'
from erp_june.hr_monthly_salary as m
left join erp_june.hr_as_basic_info as b on b.associate_id = m.as_id
left join erp_june.hr_location as loc on b.as_location = loc.hr_location_id
left join erp_june.hr_unit as u on b.as_unit_id = u.hr_unit_id
left join erp_june.hr_department as dp on b.as_department_id = dp.hr_department_id
left join erp_june.hr_designation as d on b.as_designation_id = d.hr_designation_id
left join erp_june.hr_section as s on b.as_section_id = s.hr_section_id
left join erp_june.hr_emp_type et  on et.emp_type_id  = b.as_emp_type_id 
left join erp_june.hr_subsection as sb on b.as_subsection_id = sb.hr_subsec_id
left join erp_june.hr_benefits as ben on b.associate_id = ben.ben_as_id
left join erp_june.hr_all_given_benefits as eob on eob.associate_id  = b.associate_id 
left join erp_june.monthly_leave ml on ml.leave_ass_id = b.associate_id  and ml.`month` = m.month
where m.month = '06'  and m.unit_id = 8 

```
