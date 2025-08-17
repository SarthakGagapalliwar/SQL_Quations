-- Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.

select first_name,last_name,
count(*) as admissions_total
from admissions
join doctors d
on d.doctor_id = admissions.attending_doctor_id
group by admissions.attending_doctor_id


-- For each doctor, display their id, full name, and the first and last admission date they attended.
select
	doctor_id,
    concat(first_name,' ',last_name) as full_name,
    max(admission_date) as last_admission_date,
    min(admission_date) as first_admission_date
from doctors d
	join admissions on d.doctor_id=admissions.attending_doctor_id
    
group by admissions.attending_doctor_id    


-- Display the total amount of patients for each province. Order by descending
SELECT pn.province_name, COUNT(*) AS patients_count
FROM province_names pn
JOIN patients p ON pn.province_id = p.province_id
GROUP BY pn.province_name
order by patients_count desc;


-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select concat(patients.first_name, ' ',patients.last_name) as patient_name,
	diagnosis,
    concat(doctors.first_name,' ',doctors.last_name) as doctor_name
from admissions a 
	JOIN patients ON a.patient_id=patients.patient_id
    join doctors on a.attending_doctor_id=doctors.doctor_id



-- display the first name, last name and number of duplicate patients based on their first name and last name.
-- Ex: A patient with an identical name can be considered a duplicate.
select first_name,last_name,count(*) as num_of_duplicate
from patients
group by first_name,last_name
having num_of_duplicate>1;


-- //Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date,
-- gender non abbreviated.

-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.

select concat(first_name, ' ', last_name),
	round(height/30.48,1) as height_Feet,
    round(weight*2.205,0) as weight_Pound,
    birth_date,
    case 
     	when gender='M' then 'Male'
    else 'Female'
    End AS gender_type
from patients



-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
select patient_id, first_name,last_name
from patients
where patient_id not in
(select admissions.patient_id from admissions)


SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
  left join admissions on patients.patient_id = admissions.patient_id
where admissions.patient_id is NULL



-- Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. Average is rounded to 2 decimal places.
select 
	max(no_admission) as max_visits,
    min(no_admission) as min_visits,
    round(avg(no_admission),2) as average_visites 
from
(select admission_date, count(*) AS no_admission
from admissions
group by admission_date)