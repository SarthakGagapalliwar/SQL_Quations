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
