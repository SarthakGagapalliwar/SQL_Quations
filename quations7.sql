

-- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
select pr.province_name
from patients p
join province_names pr 
on p.province_id = pr.province_id
group by pr.province_name
having 
	count(case when p.gender='M' then 1 end)>
    count(case when p.gender='F' then 1 end)


SELECT province_name
FROM (
    SELECT
      province_name,
      SUM(gender = 'M') AS n_male,
      SUM(gender = 'F') AS n_female
    FROM patients pa
      JOIN province_names pr ON pa.province_id = pr.province_id
    GROUP BY province_name
  )
WHERE n_male > n_female


-- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- - First_name contains an 'r' after the first two letters.
-- - Identifies their gender as 'F'
-- - Born in February, May, or December
-- - Their weight would be between 60kg and 80kg
-- - Their patient_id is an odd number
-- - They are from the city 'Kingston'

select * 
from patients
where first_name Like '__r%' 
AND gender='F'
AND month(birth_date) in (2,5,12) and
weight between 60 and 80
And patient_id%2 !=0
and city = 'Kingston'


-- Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
select
concat(
round(
(select count(*) from patients
where gender ='M')/ casT(count(*) as float),4) * 100, '%') 
as male_percent
from patients


SELECT
  round(100 * avg(gender = 'M'), 2) || '%' AS percent_of_male_patients
FROM
  patients;



-- Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
select province_name
from province_names
order by
	(case when province_name = 'Ontario' then 4  --this  any int is beause of int comes frist
     else province_name end)


select province_name
from province_names
order by
  (not province_name = 'Ontario'),
  province_name



-- We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.

select d.doctor_id, concat(d.first_name,' ', d.last_name) as doctor_name,d.specialty, 
Year(a.admission_date) as selected_year,
count(*) as total_admission
from doctors d 
join admissions a on d.doctor_id=a.attending_doctor_id
group by d.doctor_id, selected_year


SELECT
  d.doctor_id as doctor_id,
  CONCAT(d.first_name,' ', d.last_name) as doctor_name,
  d.specialty,
  YEAR(a.admission_date) as selected_year,
  COUNT(*) as total_admissions
FROM doctors as d
  LEFT JOIN admissions as a ON d.doctor_id = a.attending_doctor_id
GROUP BY
  doctor_name,
  selected_year
ORDER BY doctor_id, selected_year