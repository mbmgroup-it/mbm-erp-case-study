```php
    public function processLeftSalary()
    {
        $data = array(
            '12M103021N' => '2021-01-08',
            '14M103384N' => '2021-01-06',
            '16K103041N' => '2021-01-06',
        );
        $emps = DB::table('hr_as_basic_info as b')
            ->whereIn('b.associate_id', array_keys($data))
            ->leftJoin('hr_benefits as ben', 'b.associate_id','ben.ben_as_id')
            ->where('b.as_unit_id', 2)
            ->where('b.as_status', '!=', 1)
            ->get();
        foreach ($emps as $key => $v) {
            \App\Helpers\EmployeeHelper::processPartialSalary($v, $data[$v->associate_id],2);
        }
        return 'done';
    }
```

