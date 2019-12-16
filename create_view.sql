CREATE VIEW MenuItem_v AS
SELECT mi.itemName, mi.spiceLevel, mmi.itemPrice, alc.menuType, mmi.size
    FROM menuItem mi INNER JOIN menuMenuItem mmi ON mi.itemID = mmi.itemID
                  INNER JOIN aLaCarte alc ON alc.menuID = mmi.menuID;


CREATE VIEW Customer_addresses_v AS
SELECT customer.customerID, snailMail AS "Address", 'Individual' AS "Account Type", cFirstName AS "Primary Name", cLastName AS "Secondary Name"
    FROM individual INNER JOIN customer ON individual.customerID = customer.customerID
UNION
SELECT customerID, officeAddress, 'Corporation', corporationName, organizationName
    FROM corporation;


CREATE VIEW Sous_mentor_v AS
SELECT mentor.eFirstName AS "Mentor First Name", mentor.eLastName AS "Mentor Last Name", mentee.eFirstName AS "Mentee First Name", mentee.eLastName AS "Mentee Last Name", s.specialty, ms.startDate
    FROM employee mentor INNER JOIN mentorShip ms ON ms.eID = mentor.eID
                         INNER JOIN specialty s ON s.eID = ms.sChefID
                         INNER JOIN employee mentee ON mentee.eID = ms.sChefID
ORDER BY mentor.eFirstName, mentee.eFirstname;


CREATE VIEW Customer_Sales_V AS
SELECT YEAR(o.orderDate) AS "Year", SUM(o.totalAmount) AS "Total Spent"
    FROM orders o
GROUP BY o.customerID;


CREATE VIEW Customer_Value_v AS
SELECT c.customerID, c.cFirstName, c.cLastName, SUM(o.totalAmount) AS "Total Spent"
    FROM customer c INNER JOIN orders o ON c.customerID = o.customerID
WHERE YEAR(o.orderDate) = '2019'
GROUP BY o.customerID
ORDER BY SUM(o.totalAmount) ASC;


