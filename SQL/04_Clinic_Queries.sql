#1
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

#2
SELECT customer.name, SUM(clinic_sales.amount) AS total_spent
FROM customer
JOIN clinic_sales ON customer.uid = clinic_sales.uid
WHERE YEAR(clinic_sales.datetime) = 2021
GROUP BY customer.name
ORDER BY total_spent DESC

#3
SELECT 
    MONTH(cs.datetime) AS month,
    SUM(cs.amount) AS revenue,
    SUM(e.amount) AS expense,
    (SUM(cs.amount) - SUM(e.amount)) AS profit,
    CASE WHEN (SUM(cs.amount) - SUM(e.amount)) > 0 THEN 'Profitable'
         ELSE 'Not Profitable' END AS status
FROM clinic_sales cs
LEFT JOIN expenses e ON MONTH(cs.datetime) = MONTH(e.datetime)
    AND YEAR(cs.datetime) = YEAR(e.datetime)
WHERE YEAR(cs.datetime) = 2021
GROUP BY MONTH(cs.datetime);

#4
SELECT city, clinic_name, (SUM(cs.amount) - SUM(e.amount)) AS profit
FROM clinics
JOIN clinic_sales cs ON clinics.cid = cs.cid
LEFT JOIN expenses e ON clinics.cid = e.cid
WHERE MONTH(cs.datetime) = 9 AND YEAR(cs.datetime) = 2021
GROUP BY city, clinic_name
ORDER BY city, profit DESC;

#5
SELECT state, clinic_name, (SUM(cs.amount) - SUM(e.amount)) AS profit
FROM clinics
JOIN clinic_sales cs ON clinics.cid = cs.cid
LEFT JOIN expenses e ON clinics.cid = e.cid
WHERE MONTH(cs.datetime) = 9 AND YEAR(cs.datetime) = 2021
GROUP BY state, clinic_name
ORDER BY state, profit ASC;
