Create a view to show monthly leave data for an employee

```sql
CREATE VIEW monthly_leave as
SELECT leave_ass_id , MONTH(leave_from) as 'month', Year(leave_from) as 'year',
SUM(CASE WHEN leave_type = 'Casual' THEN DATEDIFF(leave_to, leave_from)+1 END) AS casual, 
SUM(CASE WHEN leave_type = 'Sick' THEN DATEDIFF(leave_to, leave_from)+1 END) AS sick, 
SUM(CASE WHEN leave_type = 'Earned' THEN DATEDIFF(leave_to, leave_from)+1 END) AS earned 
FROM hr_leave 
where leave_from >= '2021-03-01' and leave_to <= '2021-06-30' 
group by leave_ass_id, MONTH(leave_from), Year(leave_from)
```
