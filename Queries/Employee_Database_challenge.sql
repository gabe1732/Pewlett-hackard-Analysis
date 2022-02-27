-- Create retirement_titles db
SELECT e.emp_no
,e.first_name
,e.last_name
,tl.title
,tl.from_date
,tl.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles as tl
		ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, e.emp_no DESC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no
,rt.first_name
,rt.last_name
,rt.title
INTO retiree_current_title
FROM retirement_titles AS rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

-- Employee count by title
SELECT COUNT(rc.emp_no)
,rc.title
INTO retiring_titles
FROM retiree_current_title as rc
GROUP BY rc.title
ORDER BY count desc;

-- Mentorship Queiries 
SELECT DISTINCT ON (e.emp_no) e.emp_no
	,e.first_name
	,e.last_name
	,e.birth_date
	,d.from_date
	,d.to_date
	,tl.title
INTO mentorship_eligibilty
FROM employees AS e
	INNER JOIN dept_emp AS d
		ON (e.emp_no = d.emp_no)
	INNER JOIN titles AS tl
		ON (e.emp_no = tl.emp_no)
WHERE d.to_date = ('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
