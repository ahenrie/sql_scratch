-1 Remove 'Trucking' from anywhere in the Carriers table.
Update Carriers
SET CarrierName = REPLACE(CarrierName, 'Trucking', '')
FROM Carriers;
GO

--2 Make the long sentences
SELECT
CONCAT('Shipment ID number ', sh.ShipmentID,
	CASE
		WHEN sh.DepartDateTime < GETDATE() THEN ' departed from '
		WHEN sh.DepartDateTime > GETDATE() THEN ' will depart from '
	END,
		t.TerminalCity, ', ', t.TerminalState, ' (',sh.DepartCode, '), on ', 
		DATENAME(dw,sh.DepartDateTime), ', ', DATENAME(m,sh.DepartDateTime), ' ',
	CASE
		WHEN DATENAME(d,sh.DepartDateTime) = 1 THEN CONCAT(DATENAME(d,sh.DepartDateTime), 'st, at ')
		WHEN DATENAME(d,sh.DepartDateTime) = 21 THEN CONCAT(DATENAME(d,sh.DepartDateTime), 'st, at ')
		WHEN DATENAME(d,sh.DepartDateTime) = 31 THEN CONCAT(DATENAME(d,sh.DepartDateTime), 'st, at ')
		WHEN DATENAME(d,sh.DepartDateTime) = 2 THEN CONCAT(DATENAME(d,sh.DepartDateTime), 'nd, at ')
		WHEN DATENAME(d,sh.DepartDateTime) = 22 THEN CONCAT(DATENAME(d,sh.DepartDateTime), 'nd, at ')
		WHEN DATENAME(d,sh.DepartDateTime) = 3 THEN CONCAT(DATENAME(d,sh.DepartDateTime), 'rd, at ')
		WHEN DATENAME(d,sh.DepartDateTime) = 23 THEN CONCAT(DATENAME(d,sh.DepartDateTime), 'rd, at ')
		ELSE CONCAT(DATENAME(d,sh.DepartDateTime), 'th, at ')
	END,
		LEFT(CONVERT(VARCHAR(20), sh.DepartDateTime, 14),5),'. ',--1st Sentence
		c.CarrierName,'''s ', tr.Manufacturer,' ', tr.Model, ' which was last serviced on ', CONVERT(VARCHAR(20), tr.LastServiceDate, 107),
	CASE
		WHEN sh.DepartDateTime < GETDATE() THEN ', was the truck used for the shipment. The shipment arrived in '
		WHEN sh.DepartDateTime > GETDATE() THEN ' will be the truck used for the shipment. The shipment will arive in '
	END,
		ta.TerminalCity, ', ', ta.TerminalState, ' (',sh.ArriveCode, '), on ', DATENAME(dw,sh.ArriveDateTime), ', ', DATENAME(m,sh.ArriveDateTime), ' ',
	CASE
		WHEN DATENAME(d,sh.ArriveDateTime) = 1 THEN CONCAT(DATENAME(d,sh.ArriveDateTime), 'st, at ')
		WHEN DATENAME(d,sh.ArriveDateTime) = 21 THEN CONCAT(DATENAME(d,sh.ArriveDateTime), 'st, at ')
		WHEN DATENAME(d,sh.ArriveDateTime) = 31 THEN CONCAT(DATENAME(d,sh.ArriveDateTime), 'st, at ')
		WHEN DATENAME(d,sh.ArriveDateTime) = 2 THEN CONCAT(DATENAME(d,sh.ArriveDateTime), 'nd, at ')
		WHEN DATENAME(d,sh.ArriveDateTime) = 22 THEN CONCAT(DATENAME(d,sh.ArriveDateTime), 'nd, at ')
		WHEN DATENAME(d,sh.ArriveDateTime) = 3 THEN CONCAT(DATENAME(d,sh.ArriveDateTime), 'rd, at ')
		WHEN DATENAME(d,sh.ArriveDateTime) = 23 THEN CONCAT(DATENAME(d,sh.ArriveDateTime), 'rd, at ')
		ELSE CONCAT(DATENAME(d,sh.ArriveDateTime), 'th, at ')
	END,
	LEFT(CONVERT(VARCHAR(20), sh.ArriveDateTime, 14),5), '.'
)
'Shipment Info'
FROM Shipments sh JOIN Trucks tr ON sh.VIN = tr.VIN
JOIN Carriers c ON c.CarrierID = tr.CarrierID
JOIN Terminals t ON sh.DepartCode = t.TerminalCode
JOIN Terminals ta ON sh.ArriveCode = ta.TerminalCode
;
GO

--3 Return all carriers that use 'Freightliner' as a truck manufacturer with no joins
SELECT CarrierName FROM Carriers
WHERE CarrierID IN
	(SELECT CarrierID FROM Trucks
	WHERE Manufacturer = 'Freightliner')
ORDER BY 1;
GO
