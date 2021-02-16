```
    public function migrateAll(){
        $data = DB::table('hr_worker_recruitment')
            ->where('worker_unit_id', 8)
            ->whereNotNull('worker_department_id')
            ->take(10)
            ->get();
            $d = [];
        foreach ($data as $key => $worker) {
            DB::beginTransaction();
            try {
                if ( ($worker->worker_unit_id != null || $worker->worker_unit_id != ''))
                {
                    $location= DB::table('hr_location')->where('hr_location_unit_id', $worker->worker_unit_id)->orderBy('hr_location_id', 'asc')->first(['hr_location_id']); 
                    $shift_exist= DB::table('hr_shift')
                            ->where('hr_shift_unit_id', $worker->worker_unit_id)
                            ->where('hr_shift_default', 1)
                            ->pluck('hr_shift_name')
                            ->first();
                    
                    $IDGenerator = (new  \App\Http\Controllers\Hr\IDGenerator)->generator2(array(
                        'department' => $worker->worker_department_id,
                        'date' => $worker->worker_doj
                    ));

                    

                    if (!empty($IDGenerator['error']))
                    {
                        /*toastr()->error($IDGenerator['error']);
                        return back()->with("error", $IDGenerator['error']);*/
                    }
                    else if(strlen($IDGenerator['id']) != 10)
                    {
                        /*toastr()->error("Unable to start the migration: Alphanumeric Associate's ID required with exactly 10 characters ");
                        return back()->with("error", "Unable to start the migration: Alphanumeric Associate's ID required with exactly 10 characters ");*/
                    }
                    else if($shift_exist == null)
                    {
                        /*toastr()->error("Unable to start the migration: Default Shift Doesn't Exist ");
                        return back()->with("error", "Unable to start the migration: Default Shift Doesn't Exist ");*/
                    }
                    else
                    {
                        //Default Shift Code
                        $default_shift= DB::table('hr_shift')
                        ->where('hr_shift_unit_id', $worker->worker_unit_id)
                        ->where('hr_shift_default', 1)
                        ->pluck('hr_shift_name')
                        ->first();
                        /*---INSERT INTO BASIC INFO TABLE---*/
                        $check = Employee::insert(array(
                            'as_emp_type_id'  => $worker->worker_emp_type_id,
                            'as_unit_id'      => $worker->worker_unit_id,
                            'as_shift_id'     => $default_shift,
                            'as_area_id'      => $worker->worker_area_id,
                            'as_department_id' => $worker->worker_department_id,
                            'as_section_id'  => $worker->worker_section_id,
                            'as_subsection_id'  => $worker->worker_subsection_id,
                            'as_designation_id' => $worker->worker_designation_id,
                            'as_doj'         => (!empty($worker->worker_doj)?date('Y-m-d',strtotime($worker->worker_doj)):null),
                            'temp_id'        => $IDGenerator['temp'],
                            'associate_id'   => $IDGenerator['id'],
                            'as_name'        => $worker->worker_name,
                            'as_gender'      => $worker->worker_gender,
                            'as_dob'         => (!empty($worker->worker_dob)?date('Y-m-d',strtotime($worker->worker_dob)):null),
                            'as_contact'     => $worker->worker_contact,
                            'as_ot'          => $worker->worker_ot,
                            'as_oracle_code' => $worker->as_oracle_code,
                            'as_oracle_sl'   => ($worker->as_oracle_code != ''?substr($worker->as_oracle_code,3, -1):''),
                            'as_rfid_code'   => $worker->as_rfid,
                            'as_pic'         => null,
                            'created_at'     => date("Y-m-d H:i:s"),
                            'created_by'     => Auth::user()->id,
                            'as_status'      => 1 ,
                            'as_location'    => $location->hr_location_id??''
                        ));

                        DB::table('hr_med_info')->insert(array(
                            'med_as_id'       => $IDGenerator['id'],
                            'med_height'      => $worker->worker_height,
                            'med_weight'      => $worker->worker_weight,
                            'med_tooth_str'   => $worker->worker_tooth_structure,
                            'med_blood_group' => $worker->worker_blood_group,
                            'med_ident_mark'  => (!empty($worker->worker_identification_mark)?$worker->worker_identification_mark:"N/A"),
                            'med_doct_comment'   => $worker->worker_doctor_comments,
                            'med_doct_conf_age'  => $worker->worker_doctor_age_confirm,
                            'med_doct_signature' => $worker->worker_doctor_signature
                        ));

                        DB::table('hr_as_adv_info')->insert(array(
                            'emp_adv_info_as_id' => $IDGenerator['id'],
                            'emp_adv_info_nid'   => $worker->worker_nid
                        ));


                        $t = DB::table('hr_worker_recruitment')->where('worker_id', $worker->worker_id)
                            ->delete();

                        // make default absent
                        DB::table('hr_absent')->insert([
                            'associate_id' => $IDGenerator['id'],
                            'date' => date('Y-m-d'),
                            'hr_unit' => $worker->worker_unit_id
                        ]);
                        $d[] = $IDGenerator['id'];
                        

                        //Cache::forget('employee_count');
                        DB::commit();
                        /*toastr()->success('Migration successful!');
                        $this->logFileWrite("Employee migration updated", $request->worker_id);
                        return back()->with("success", "Migration successful!");*/
                    }
                }
                else
                {
                    /*toastr()->error("Unable to start the migration: Please check the user's medical status or user already migrated!");
                    return back()->with("error", "Unable to start the migration: Please check the user's medical status or user already migrated!");*/
                }
                
            } catch (\Exception $e) {
                $d[] = $e->getMessage();
                DB::rollback();
            }
        }

        return $d;
    }
```
