
--Table Checker
SELECT * FROM Shipments;
SELECT * FROM Carriers;
SELECT * FROM Terminals;
SELECT * FROM Trucks;

--1 Add "Reliable Trucking" to table Carriers
INSERT INTO Carriers
VALUES
('Reliable Trucking');
GO

--2 Update 'Simon' to 'Simon Trucking'in table Carriers
UPDATE Carriers
SET CarrierName = 'Simon Trucking'
WHERE CarrierID = 4;
GO

--3 SFC in San Francisco and ending in New York (NYC) after October of this year have been cancelled.
DELETE FROM Shipments
WHERE DepartCode = 'SFC' 
AND ArriveCode = 'NYC'
AND MONTH(DepartDateTime)>10 
AND YEAR(DepartDateTime)=YEAR(GETDATE());
GO

--4 List all carriers with shipment counts descending
SELECT CarrierName, COUNT(ShipmentID) 'Shipment Count'
FROM Carriers C LEFT JOIN Shipments SH
ON C.CarrierID = SH.CarrierID
GROUP BY C.CarrierName
ORDER BY 2 DESC;
GO

--5 List Terminal City and State with Arrival Shipment Count. List by City Alphabetically. 
SELECT TerminalCity, TerminalState, COUNT(ArriveDateTime) 'Arrival Count'
FROM Terminals T JOIN Shipments SH
ON T.TerminalCode = SH.ArriveCode
GROUP BY TerminalCity, TerminalState
ORDER BY TerminalCity;
GO

--6 List Carriers alphabetically their types of trucks with manufacturer and model together alphabetically
SELECT CarrierName, CONCAT(Manufacturer, ' ', Model) AS 'Owned Trucks'
FROM Carriers C JOIN Trucks Tr
ON C.CarrierID = Tr.CarrierID
GROUP BY CarrierName, Manufacturer, Model
ORDER BY CarrierName, 'Owned Trucks';
GO
