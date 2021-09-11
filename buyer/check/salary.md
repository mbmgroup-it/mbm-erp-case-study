Check salary difference 
```sql
select 
b.as_name,b.associate_id, b.as_id,
ms.salary_payable - ms2.salary_payable as diff,
ms.present, ms.absent, ms.holiday, ms.`leave`, ms.salary_payable, ms.attendance_bonus, 
ms.stamp, ms.absent_deduct,
ms2.present as present_buyer, ms2.absent as absent_buyer, ms2.holiday as holiday_buyer , 
ms2.`leave` as leave_buyer, ms2.salary_payable as salary_payable_buyer, 
ms2.attendance_bonus as attendance_bonus_buyer, 
ms2.stamp as stamp_buyer, ms2.absent_deduct as absent_deduct_buyer
from suadmin_erp.hr_monthly_salary ms 
left join suadmin_erp.hr_as_basic_info as b on b.associate_id = ms.as_id 
left join suadmin_erp.hr_buyer_salary_ceil4 as ms2 
on ms2.as_id = b.as_id and ms2.`month` = ms.`month` and ms2.`year` = ms.`year` 
where ms2.`month` = '08'  and b.as_unit_id = 2 and b.as_location = 7
```
