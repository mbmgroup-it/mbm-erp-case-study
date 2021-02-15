```
    public function advBn()
    {
        $data = array(
                 '20K1469E' => array('SALARY' => '9500', 'J_SAL' => '9500', 'MARRIED' => 'M', 'FNAME' => 'MD.Demo', 'HNAME' => '', 'PAD1' => 'Demo', 'PAD2' => '', 'PPOST' => 'HOLDIBARI-5470', 'PTHANA' => 'PIRGANJ', 'PDIST' => '32', 'CAD1' => 'SALNA', 'CAD2' => '', 'CPOST' => 'SALNA BAZAR', 'CTHANA' => '154', 'CDIST' => '3', 'B_NAME' => 'মোঃ লেবু মন্ডল', 'MOTHER' => 'মোছাঃ রোকেয়া বেগম', 'BFATHER' => 'মোঃ আব্দুল মান্নান মন্ডল', 'BGRAM' => 'বড় বদনাপাড়া', 'BPOST' => 'হলদীবাড়ী', 'MNAME' => 'MST.ROKEYA BEGUM', 'HOUSE_NO' => 'সালনা', 'ROAD_NO' => '', 'PO' => 'সালনা বাজার', 'CHILDREN' => '', 'CLASS' => 'EIGHT', 'RELEG' => 'I')
            );


        $as = DB::table('hr_as_basic_info')
            ->where('as_unit_id', 3)
            ->pluck('associate_id','as_oracle_code');

        $bn = DB::table('hr_employee_bengali')
                ->whereIn('hr_bn_associate_id', $as)
                ->pluck('hr_bn_associate_id')->toArray();
        $insert = [];
        foreach ($data as $key => $v) {
            if(isset($as[$key])){
                DB::table('hr_as_adv_info')
                    ->where('emp_adv_info_as_id', $as[$key])
                    ->update([
                        'emp_adv_info_nationality' => 'BANGLADESHI', 
                        'emp_adv_info_fathers_name' => $v['FNAME'], 
                        'emp_adv_info_mothers_name' => $v['MNAME'], 
                        'emp_adv_info_spouse' => $v['HNAME'], 
                        'emp_adv_info_children' => $v['CHILDREN'], 
                        //'emp_adv_info_religion' => $v['FNAME'], 
                        'emp_adv_info_per_vill' => $v['PAD1'],
                        'emp_adv_info_per_po' => $v['PPOST'],
                        'emp_adv_info_per_dist' => $v['PDIST'],
                        'emp_adv_info_pres_house_no' => $v['CAD1'],
                        'emp_adv_info_pres_road' => $v['CAD2'],
                        'emp_adv_info_pres_po' => $v['CPOST'],
                        'emp_adv_info_pres_dist' => $v['CDIST'],
                        'emp_adv_info_pres_upz' => $v['CTHANA'],
                    ]);

                if(in_array($as[$key], $bn)){
                    DB::table('hr_employee_bengali')
                        ->where('hr_bn_associate_id', $as[$key])
                        ->update([
                        'hr_bn_associate_name' => $v['B_NAME'], 
                        'hr_bn_father_name' => $v['BFATHER'], 
                        'hr_bn_mother_name' => $v['MOTHER'], 
                        'hr_bn_permanent_village' => $v['BGRAM'],
                        'hr_bn_permanent_po' => $v['BPOST'],
                        'hr_bn_present_road' => $v['ROAD_NO'],
                        'hr_bn_present_house' => $v['HOUSE_NO'],
                        'hr_bn_present_po' => $v['PO']
                    ]);

                }else{
                    $insert[$key] = [
                        'hr_bn_associate_id' => $as[$key],
                        'hr_bn_associate_name' => $v['B_NAME'], 
                        'hr_bn_father_name' => $v['BFATHER'], 
                        'hr_bn_mother_name' => $v['MOTHER'], 
                        'hr_bn_permanent_village' => $v['BGRAM'],
                        'hr_bn_permanent_po' => $v['BPOST'],
                        'hr_bn_present_road' => $v['ROAD_NO'],
                        'hr_bn_present_house' => $v['HOUSE_NO'],
                        'hr_bn_present_po' => $v['PO']
                    ];
                }
            }
        }
        DB::table('hr_employee_bengali')->insert($insert);

        return 'success';
    }
```
