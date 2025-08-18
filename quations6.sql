-- Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

select
	count(weight) as patients_in_group,
	floor(weight/10)*10 as weight_group
from patients
group by weight_group
order by weight_group desc

SELECT
  TRUNCATE(weight, -1) AS weight_group,
  count(*)
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;



-- Show patient_id, weight, height, isObese from the patients table.
-- Display isObese as a boolean 0 or 1.
-- Obese is defined as weight(kg)/(height(m)2) >= 30.
-- weight is in units kg.
-- height is in units cm.

select patient_id, weight, height,

	(case 
        wHEN weight/power((height/100.0),2)>=30
        	then 1
        else 0
    end) as isObese    
        
from patients



-- Show patient_id, first_name, last_name, and attending doctor's specialty.
-- Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
-- Check patients, admissions, and doctors tables for required information.
select p.patient_id as patient_id,
p.first_name as patient_first_name, p.last_name as patient_last_name,
d.specialty as attending_doctor_specialty
from patients p
	join admissions on
    p.patient_id=admissions.patient_id
    join doctors d on
    d.doctor_id=admissions.attending_doctor_id
where admissions.diagnosis= 'Epilepsy' AND d.first_name='Lisa';




-- All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date

SELECT 
    patients.patient_id, 
    CONCAT(patients.patient_id, LEN(patients.last_name), YEAR(patients.birth_date)) AS temp_password
FROM patients
join admissions on patients.patient_id=admissions.patient_id
group by patients.patient_id;



-- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.
select 
	(
     case when patients.patient_id%2=0 then 'Yes'
     else 'NO'
     end 
    ) as has_inusrance,
   	
    sum( case when patients.patient_id%2=0 then 10
        else 50 
        end) as cost_after_insurance
      
from patients
join admissions
on patients.patient_id = admissions.patient_id
group by has_inusrance


