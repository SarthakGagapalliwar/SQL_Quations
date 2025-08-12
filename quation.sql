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



