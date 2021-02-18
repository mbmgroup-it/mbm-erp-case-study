```php
    public function processBuyerLeftSalary()
    {
        
        $datas = DB::table('hr_monthly_salary as s')
            ->select('s.*','b.as_id as ass')
            ->leftJoin('hr_as_basic_info as b', 'b.associate_id','s.as_id')
            ->where('b.as_unit_id', 2)
            ->where('s.month','01')
            ->where('s.emp_status',5)
            ->whereNull('s.disburse_date')
            ->where('s.location_id',7)
            ->get();

        $as_id = collect($datas)->pluck('ass');


        $buyer_sal = DB::table('hr_buyer_salary_ceil4 as s')
                    ->select('s.*')
                    ->leftJoin('hr_as_basic_info as b','b.as_id','s.as_id')
                    ->whereIn('s.as_id', $as_id)
                    ->where('b.as_unit_id', 2)
                    ->where('s.month', '01')
                    ->get()
                    ->keyBy('as_id');

        foreach ($datas as $key => $v) {
            if(isset($buyer_sal[$v->ass])){
                    $sl = $buyer_sal[$v->ass];
                    $deductCost = ($sl->adv_deduct + $sl->cg_deduct + $sl->food_deduct + $sl->others_deduct);
                    $ot = ($v->ot_rate*$sl->ot_hour);
                    $lvadjust = $sl->leave_adjust;
                    $deductSalaryAdd = $sl->salary_add;
            }else{
                    $adv_deduct = 0;
                        $cg_deduct = 0;
                        $food_deduct = 0;
                        $others_deduct = 0;
                        $salary_add = 0;
                        $bonus_add = 0;
                        $deductCost = 0;
                        $productionBonus = 0;

                        $getAddDeduct = DB::table('hr_salary_add_deduct')
                            ->where('associate_id', $v->as_id)
                            ->where('month', '=', '01')
                            ->where('year', '=', 2021)
                            ->first();

                        if($getAddDeduct != null){
                            $advp_deduct = $getAddDeduct->advp_deduct;
                            $cg_deduct = $getAddDeduct->cg_deduct;
                            $food_deduct = $getAddDeduct->food_deduct;
                            $others_deduct = $getAddDeduct->others_deduct;
                            $salary_add = $getAddDeduct->salary_add;
                            $deductSalaryAdd = $salary_add;

                            $deductCost = ($advp_deduct + $cg_deduct + $food_deduct + $others_deduct);
                            $productionBonus = $getAddDeduct->bonus_add;
                        }

                    $ot = DB::table('hr_buyer_att_ceil4')
                            ->where('as_id', $v->ass)
                            ->where('in_date','<=','2021-01-30')
                            ->sum('ot_hour');

                    $ot_num_min = min_to_ot();

                        if($ot > 0){
                            $otfm = explode(".", $ot);

                            if(isset($otfm[1])){
                                $ot_min = round((('0.'.$otfm[1]) * 60));
                                $ot_hour = $otfm[0] + ($ot_min == 1? 1:($ot_num_min[$ot_min]));
                            }else{
                                $ot_hour = $ot;
                            }
                        }

                    $ot = $ot*$v->ot_rate;
                    $lvadjust = 0;


            }
            $at = [
                'present' => $v->present,
                'absent' => $v->absent,
                'holiday' => $v->holiday,
                'late_count' => $v->late_count,
                'leave' => $v->leave,
                'ot_rate' => $v->ot_rate,
                'stamp' => 10,
                'pay_type' => null,
                'emp_status' => 5,
                'disburse_date' => null
            ];

            $attBonus = 0;
            $salary_date = $v->present + $v->holiday + $v->leave + $v->absent;
            $stamp = 10;
            

            $perDayBasic = round(($v->basic / 30),2);
            $perDayGross = round(($v->gross /  31),2);
            $getAbsentDeduct = $v->absent * $perDayBasic;

            
            
            // get salary payable calculation
            $salaryPayable = round((($perDayGross*$salary_date) - ($getAbsentDeduct + $deductCost + $stamp)), 2);
            

            $totalPayable = ceil((float)($salaryPayable + $ot   + $v->production_bonus + $lvadjust));
            
            $at['total_payable'] = $totalPayable;
            $at['cash_payable'] = $totalPayable;
            $at['bank_payable'] = 0;
            $at['salary_payable'] = $salaryPayable;
            $at['leave_adjust'] = $lvadjust;
            $at['absent_deduct'] = $getAbsentDeduct;

            if(isset($buyer_sal[$v->ass])){

                DB::table('hr_buyer_salary_ceil4')
                    ->where('as_id', $v->ass)
                    ->where('id', $sl->id)
                    ->update($at);
            }else{
                $at['month'] = '01';
                $at['as_id'] = $v->ass;
                $at['year'] = 2021;

                $at['gross'] = $v->gross;
                $at['basic'] = $v->basic;
                $at['house'] = $v->house;
                $at['medical'] = $v->medical;
                $at['transport'] = $v->transport;
                $at['food'] = $v->food;
                $at['late_count'] = $v->late_count;
                $at['absent_deduct'] = $getAbsentDeduct;
                $at['adv_deduct'] = $adv_deduct;
                $at['cg_deduct'] = $cg_deduct;
                $at['food_deduct'] = $food_deduct;
                $at['others_deduct'] = $others_deduct;
                $at['salary_add'] = $salary_add;
                $at['bonus_add'] = $bonus_add;
                $at['leave_adjust'] = $v->leave_adjust;
                $at['ot_hour'] = $ot_hour;
                $at['attendance_bonus'] = 0;
                $at['production_bonus'] = $productionBonus;
                $at['stamp'] = 10;
                $at['salary_payable'] = $salaryPayable;
                $at['total_payable'] = $totalPayable;
                $at['cash_payable'] = $totalPayable;
                $at['bank_payable'] = 0;
                $at['tds'] = 0;
                $at['pay_status'] = $v->pay_status;
                $at['pay_type'] = $v->pay_type;
                $at['emp_status'] = $v->emp_status;
                $at['ot_status'] = $v->ot_status;
                $at['designation_id'] = $v->designation_id;
                $at['subsection_id'] = $v->sub_section_id;
                $at['location_id'] = $v->location_id;
                $at['unit_id'] = $v->unit_id;
                DB::table('hr_buyer_salary_ceil4')->insert($at);
            }


            
            
        }


        DB::table('hr_buyer_salary_ceil4')
            ->whereNotIn('as_id', $as_id)
            ->where('emp_status', 5)
            ->where('month', '01')
            ->update([
                'disburse_date'=> '2021-01-30'
            ]);


        return 'hi';
    }
```

