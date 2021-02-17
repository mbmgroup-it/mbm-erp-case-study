```php
    public function jobcardupdate()
    {
        $data = DB::table('hr_attendance_ceil')
            ->where('in_date','2021-01-03')
            ->get();

        foreach ($data as $key => $v) 
        {

            if($v->in_time && $v->out_time){

                $queue = (new ProcessAttendanceInOutTime('hr_attendance_ceil', $v->id, 2))
                        ->delay(Carbon::now()->addSeconds(2));
                        dispatch($queue);
            }
            
        }
        return 'success 30';

    } 
```
