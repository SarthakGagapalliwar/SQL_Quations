-- Show first name, last name, and the full province name of each patient
select first_name,last_name,province_name
FROM patients
join province_names
ON province_names.province_id=patients.province_id;


-- Show how many patients have a birth_date with 2010 as the birth year.
select count(*)
from patients
where year(birth_date)=2010


-- Show the first_name, last_name, and height of the patient with the greatest height.
select first_name,last_name,height
from patients
where height=(
	select MAX(height)
	from patients
)

-- Show all columns for patients who have one of the following patient_ids:
-- 1,45,534,879,1000
select *
from patients
where patient_id in (1,45,534,879,1000)


-- Show the total number of admissions
select count(*)
from admissions;


-- Show all the columns from admissions where the patient was admitted and discharged on the same day.
select *
from admissions
where admission_date=discharge_date;


-- Show the patient id and the total number of admissions for patient_id 579.
select patient_id,count(*) as total_admissions
from admissions
where patient_id=579


-- Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
select first_name,last_name,birth_date
from patients
where height>160 AND weight>70;



-- Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
select first_name,last_name,allergies
from patients
where allergies is NOT NULL AND city='Hamilton'; 



