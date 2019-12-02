--join 8
SELECT b.REGION_ID, region_name, country_name
FROM countries a, regions b
WHERE a.region_id = b.region_id
AND region_name IN 'Europe';

--join 9
--(row 9- france, danmark, belgium 3개 국가에 속하는 location 정보는 미존재
--나머지5개중에 다수의 location 정보를 갖고 있는 국가가 존재 한다)
SELECT b.REGION_ID, region_name, country_name, city
FROM countries a, regions b, locations
WHERE a.region_id = b.region_id
AND region_name IN 'Europe'
AND a.country_id = locations.country_id;

--join10
SELECT b.REGION_ID, region_name, country_name, city, department_name
FROM countries a, regions b, locations, departments
WHERE a.region_id = b.region_id
AND a.country_id = locations.country_id
AND locations.location_id = departments.location_id
AND region_name IN 'Europe';

--join11

SELECT b.REGION_ID, region_name, country_name, city, department_name, first_name || last_name AS NAME
FROM countries a, regions b, locations, departments, EMPLOYEES
WHERE a.region_id = b.region_id
AND a.country_id = locations.country_id
AND locations.location_id = departments.location_id 
AND (departments.MANAGER_ID = employees.MANAGER_ID OR departments.department_ID = employees.department_ID)
AND region_name IN 'Europe';

--join12
SELECT employee_id, first_name || last_name AS NAME, jobs.job_id, jobs.JOB_TITLE
FROM employees, jobs
WHERE jobs.job_id = employees.job_id;

--join13
--teacher
SELECT employees.manager_id mgr_id, 
       manager.first_name || manager.last_name AS MGR_NAME,
       employees.employee_id,
       employees.first_name || employees.last_name AS NAME,
       jobs.job_id, jobs.job_title
FROM jobs, employees, employees manager
WHERE jobs.job_id = employees.job_id
AND employees.manager_id = manager.employee_id;

--me
SELECT b.manager_id MNG_ID,
a.first_name || a.last_name AS MGR_NAME,
b.employee_id,
b.first_name || b.last_name AS NAME,
c.JOB_ID, 
job_title
FROM employees a, employees b, jobs c
WHERE b.job_id = c.job_id
AND b.MANAGER_ID = a.EMPLOYEE_ID
ORDER BY MNG_ID;