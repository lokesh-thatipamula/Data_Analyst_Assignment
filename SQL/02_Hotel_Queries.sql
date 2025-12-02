#1
SELECT u.user_id, b.room_no
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(booking_date)
    FROM bookings
    WHERE user_id = u.user_id
);


#2
SELECT bc.booking_id, SUM(i.item_rate * bc.item_quantity) AS total_billing_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
WHERE DATE(b.booking_date) BETWEEN '2021-11-01' AND '2021-11-30'
GROUP BY bc.booking_id;


#3
SELECT bc.bill_id, SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE(bc.bill_date) BETWEEN '2021-10-01' AND '2021-10-31'
GROUP BY bc.bill_id
HAVING SUM(i.item_rate * bc.item_quantity) > 1000;


#4
SELECT MONTH(bc.bill_date) AS month, i.item_name, SUM(bc.item_quantity) AS total_quantity
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date) = 2021
GROUP BY MONTH(bc.bill_date), i.item_name
ORDER BY month, total_quantity DESC;


#5
SELECT u.user_id, MONTH(bc.bill_date) AS month, SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
JOIN users u ON b.user_id = u.user_id
WHERE YEAR(bc.bill_date) = 2021
GROUP BY MONTH(bc.bill_date), u.user_id
ORDER BY month, bill_amount DESC;
