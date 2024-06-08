SELECT
    company.company_code,
    founder,
    COUNT(DISTINCT lead_manager.lead_manager_code) AS cnt_leads,
    COUNT(DISTINCT senior_manager.senior_manager_code) AS cnt_sm,
    COUNT(DISTINCT manager.manager_code) AS cnt_m,
    COUNT(DISTINCT employee.employee_code) AS cnt_e
FROM    company
    INNER JOIN lead_manager USING(company_code)
    INNER JOIN senior_manager USING(company_code, lead_manager_code)
    INNER JOIN manager USING(company_code, lead_manager_code, senior_manager_code)
    INNER JOIN employee USING(company_code, lead_manager_code, senior_manager_code, manager_code)
GROUP BY 1,2
ORDER BY 1 ASC
;