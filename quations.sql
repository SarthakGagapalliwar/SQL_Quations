-- Show first name, last name, and gender of patients whose gender is 'M'
SELECT first_name,last_name,gender 
from patients 
where gender ='M'


-- Show first name and last name of patients who does not have allergies. (null)
SELECT first_name,last_name
from patients 
where allergies is NULL;


-- Show first name of patients that start with the letter 'C'
SELECT first_name,
from patients 
where first_name LIKE 'C%';


-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name,last_name
from patients 
where weight<=120 AND weight>=100;


-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patients
SET allergies='NKA'
where allergies is null;


-- Show first name and last name concatinated into one column to show their full name.
select concat (first_name, ' ', last_name) As full_name
FROM patients



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