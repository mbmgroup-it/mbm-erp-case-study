Get Details Employee Information,

```sql
SELECT 
b.associate_id as 'Local ID',
b.associate_id as 'Global ID',
b.as_oracle_code as 'ORACLE ID',
b.as_name as 'Name',
adv.emp_adv_info_fathers_name as 'Father Name',	
adv.emp_adv_info_mothers_name as 'Mother Name',	
adv.emp_adv_info_spouse as 'Spouse Name',
b.as_contact as  'Contact',	
b.as_dob as 'Date of Birth',
adv.emp_adv_info_nid as 'NID',
b.as_gender as 'Gender',	
hmi.med_height  as 'Height',	
hmi.med_blood_group as 'Blood Group',	
adv.emp_adv_info_per_vill as 'Permanent Village',	
adv.emp_adv_info_per_po as 'Permanent PO',	
per_upz.upa_name as 'Permanent Thana',	
per_dist.dis_name as'Permanent District',	
adv.emp_adv_info_pres_house_no as 'Present House',	
adv.emp_adv_info_pres_road as 'Present Road',
adv.emp_adv_info_pres_po as 'Present PO',	
curr_upz.upa_name as 'Present Thana',
curr_dist.dis_name as 'Present District',	
hd.hr_department_name as 'Department',
hg.hr_designation_grade  as 'Grade',
hg.hr_designation_name  as 'Designation',	
b.as_doj as 'Joining Date',
adv.emp_adv_info_religion as 'Religion',
CASE when b.as_ot = 0 THEN 'Non OT' when b.as_ot = 1 THEN 'OT' END AS OT,
CASE when b.as_status = 1 THEN 'Active' when b.as_status = 2 THEN 'Resign' when b.as_status = 5 THEN 'Left' when b.as_status = 6 THEN 'Maternity' END AS Status
FROM suadmin_erp.hr_as_basic_info b
left join suadmin_erp.hr_as_adv_info adv on b.associate_id = adv.emp_adv_info_as_id 
left join suadmin_erp.hr_dist curr_dist on adv.emp_adv_info_pres_dist = curr_dist.dis_id 
left join suadmin_erp.hr_dist per_dist on adv.emp_adv_info_per_dist = per_dist.dis_id 
left join suadmin_erp.hr_upazilla curr_upz on adv.emp_adv_info_pres_upz = curr_upz.upa_id
left join suadmin_erp.hr_upazilla per_upz on adv.emp_adv_info_pres_upz = per_upz.upa_id
left join suadmin_erp.hr_designation hg  on hg.hr_designation_id  = b.as_designation_id 
left join suadmin_erp.hr_department hd on hd.hr_department_id = b.as_department_id 
left join suadmin_erp.hr_section hs on hs.hr_section_id = b.as_section_id 
left join suadmin_erp.hr_med_info hmi on hmi.med_as_id = b.associate_id 
where b.as_unit_id = 3 and b.as_status in (1,6)
```
