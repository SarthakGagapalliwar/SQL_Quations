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
