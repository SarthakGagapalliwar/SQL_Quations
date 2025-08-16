-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id,diagnosis
from admissions
group by patient_id,diagnosis
having count(*)>1


-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.
select city,count(*) as num_patients
from patients
group by city
order by num_patients desc,city asc


-- Show first name, last name and role of every person that is either patient or doctor.
-- The roles are either "Patient" or "Doctor"
select first_name,last_name,'Patient' as role
from patients
union all
select first_name,last_name, 'Doctor' as role
from doctor


-- Show all allergies ordered by popularity. Remove NULL values from query.
select allergies,count(*) as total_diagnosis
from patients
where allergies is not null
group by allergies
order by total_diagnosis desc;



-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name,last_name,birth_date
from patients
where year(birth_date) between 1970 AND 1979
order by birth_date

SELECT first_name,last_name,birth_date
FROM patients
WHERE year(birth_date) LIKE '197%'
ORDER BY birth_date ASC




-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
-- EX: SMITH,jane

select concat(upper(last_name), ',', lower(first_name))  as new_name_format
from patients
order by first_name desc

select upper(last_name) || ',' || lower(last_name) as new_name_format
from patient
order by first_name desc


-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select province_id,sum(height) as sum_height
from patients
group by province_id
having sum_height>=7000;


-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight) - min(weight) as weight_delta
from patients
where last_name = 'Maroni'


-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date) as day_number,
count(*) as number_of_admissions
from admissions
group by day_number
order by number_of_admissions desc


-- Show all columns for patient_id 542's most recent admission_date.
SELECT *
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1;

SELECT *
FROM admissions
GROUP BY patient_id
HAVING
  patient_id = 542
  AND max(admission_date)


--   Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.


select patient_id,attending_doctor_id, diagnosis
from admissions
where
(patient_id % 2!=0 AND attending_doctor_id in (1,5,19)
or 
attending_doctor_id like '%2%' 
 	and len(patient_id)=3)

