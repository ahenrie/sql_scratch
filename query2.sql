--1 CITY AND STATE OF DEPART TERMINALS WITH NUMBER OF SHIPMENTS DESCENDING. FEWER THAN 30 SHIPMENTS
SELECT t.TerminalCity, t.TerminalState, sh.DepartCode,
	COUNT(sh.DepartCode) 'Sent Shipments'
FROM Terminals t JOIN Shipments sh
ON t.TerminalCode = sh.DepartCode
WHERE getdate() > sh.DepartDateTime
GROUP BY t.TerminalCity, t.TerminalState, sh.DepartCode
HAVING COUNT(sh.DepartCode) < 30
ORDER BY 3 DESC;
GO

--2 List the number of shipments delivered by each *kind* of truck DESC
SELECT CONCAT(tr.Manufacturer, ' ', tr.Model) TruckKind, COUNT(sh.ShipmentID) ShipmentCount
FROM Trucks tr JOIN Shipments sh 
ON tr.VIN = sh.VIN
GROUP BY tr.Manufacturer, tr.Model
ORDER BY ShipmentCount DESC;
GO

--3 Insert Hauling Capacities depending on Manufacturer and Model of Truck
UPDATE Trucks
SET HaulingCap =
	CASE
		WHEN Model = 'Cascadia' THEN 40
		WHEN Model = 'Pacifica' THEN 33
		WHEN Model = 'Longhauler' THEN 28
		WHEN Model = 'Roadmaster' THEN 17
		WHEN Model = 'Streamliner' THEN 26
		WHEN Model = 'Highway Rambler' THEN 31
	END;
GO

--4 For each shipment, include the ID, depart code, arrive code, depart and arrive time, and calculations for 60%, 75%, and 90% capacity for each shipment. 
SELECT	sh.ShipmentID, sh.DepartCode, sh.ArriveCode, sh.DepartDateTime, sh.ArriveDateTime, 
		CEILING(tr.HaulingCap * .6) AS '60% Capacity',
		CEILING(tr.HaulingCap * .75) AS '75% Capacity',
		CEILING(tr.HaulingCap * .9) AS '90% Capacity' 
FROM Shipments sh JOIN Trucks tr 
ON sh.VIN = tr.VIN;
GO

--5 A query to show ShipmentID, carrier name, departure date and time, and departure and arrival terminal codes, for all orders that occur in November regardless of year. 
SELECT sh.ShipmentID, c.CarrierName, sh.DepartCode, sh.ArriveCode, 
	   sh.DepartDatetime, sh.ArriveDatetime
FROM Shipments sh JOIN Carriers c
ON sh.CarrierID = c.CarrierID
WHERE MONTH(sh.DepartDateTime) = 11 
OR MONTH(sh.ArriveDateTime) = 11
GROUP BY sh.ShipmentID, c.CarrierName, sh.DepartCode, 
		 sh.ArriveCode, sh.DepartDatetime, sh.ArriveDatetime
ORDER BY sh.DepartDateTime DESC;
GO
