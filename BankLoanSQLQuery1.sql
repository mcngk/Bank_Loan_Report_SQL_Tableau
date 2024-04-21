/*This means it will return every row and column in the dataset.*/
SELECT * FROM bank_loan_data

/* Total Loan Applications // The query above calculates the total number of loan applications in the bank_loan_data table. The result will be a single value representing the count of loan applications. If you execute this query, it will return the total count of loan applications stored in the database. */
SELECT COUNT(id) AS Total_Loan_Applications FROM bank_loan_data

/*MTD Loan Applications // The SQL query you’ve provided calculates the total number of loan applications in the bank_loan_data table specifically for the month of December 2021.*/
SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

/*PMTD Loan Applications // The query above calculates the total number of loan applications in the bank_loan_data table where the issue_date falls within the month of November (11). The result will give you the count of applications submitted during that specific month.*/
SELECT COUNT(id) AS PMTD_Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11

/*=[(MTB-PMTB)/PMTB]*/
/*Total Funded Amount */
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

/*The query above calculates the total funded amount for loans in the bank_loan_data table where the issue_date falls within the month of December (12). The result will give you the sum of loan amounts funded during that specific month.*/
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

SELECT * FROM bank_loan_data

SELECT SUM(total_payment) AS Total_Amount_received FROM bank_loan_data

/*The query above calculates the total amount received for loans in the bank_loan_data table where the issue_date falls within the month of December 2021. The result will give you the sum of payments received during that specific month*/
SELECT SUM(total_payment) AS MTD_Total_Amount_received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(total_payment) AS PMTD_Total_Amount_received FROM bank_loan_data
WHERE MONTH(issue_date) = 11


SELECT ROUND(AVG(int_rate), 4) *100 AS Avg_Interest_Rate FROM bank_loan_data

/*The query above calculates the average interest rate for loans in the bank_loan_data table where the issue_date falls within the month of December 2021. The result will give you the average interest rate expressed as a percentage, rounded to four decimal places.*/
SELECT ROUND(AVG(int_rate), 4) *100 AS MTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(int_rate), 4) *100 AS PMTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(dti), 4) * 100 AS Avg_DTI FROM bank_loan_data

SELECT ROUND(AVG(dti), 4) * 100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(dti),4) * 100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

SELECT loan_status FROM bank_loan_data 

/* The given SQL code calculates the percentage of good loans in the bank_loan_data table. Specifically, it determines the proportion of loans that are either “Fully Paid” or “Current” out of all loans in the dataset. The result is expressed as the Good_Loan_Percentage.*/
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) 
	/ 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

/* Good Loan Applications */
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/*Good Loan Funded Amount */ 
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/*Good Loan Amount Received */
SELECT SUM(total_payment) AS Good_Loan_Received_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/*Bad Loan Percentage */
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data
 
/*Bad Loan Applications */
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'
 
/* Bad Loan Funded Amount */
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'
 
/* Bad Loan Amount Received */
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received FROM bank_loan_data
WHERE loan_status = 'Charged Off'

/* LOAN STATUS */
SELECT
        loan_status,
        COUNT(id) AS Total_Loan_applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status
 

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


/* BANK LOAN REPORT | MONTH OVERVIEW  */

SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

/* STATE */
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

/* TERM */
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term

/* EMPLOYEE LENGTH */
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC  
 
/* PURPOSE */
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC 
 

/* HOME OWNERSHIP */

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC 



SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
WHERE grade = 'A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC 

