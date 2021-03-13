## Find leave records from a given range
👉 <b>Problem</b><br>
Suppose <b>leave</b> table has <br>
`id`, <br>
`employee_id`, <br>
`leave_from`, <br>
`leave_to`, <br>
`.....` columns. The task is to find leaves which is in the given range.


🎈 Solution
```php
    $data =  DB::table('hr_leave')
        ->select('employee_id', 'leave_from', 'leave_to')
        ->where('leave_to','>=',$from_date)
        ->where('leave_from','<=',$to_date)
        ->get();
```

✍ Test Case
|Leave Range | Expect | 
|---------------------|----|
|2021-03-11 2021-03-13|true|
|2021-03-11 2021-03-11|true|  
|2021-03-13 2021-03-13|true| 
|2021-03-08 2021-03-11|true|
|2021-03-08 2021-03-14|true| 
|2021-03-12 2021-03-14|true|
|2021-03-12 2021-03-12|true| 
|2021-03-07 2021-03-10|false| 
|2021-03-14 2021-03-17|false| 
