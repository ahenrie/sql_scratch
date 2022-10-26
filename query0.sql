--Key Checker
SELECT * FROM Carriers;
SELECT * FROM Trucks;
SELECT * FROM Terminals;
SELECT * FROM Shipments;
GO


--2.1 Populate Carriers table
INSERT INTO Carriers
VALUES
('CR England'),
('Swift');
GO

--2.2/2.3 Populate Trucks table
INSERT INTO Trucks
VALUES
('JH4DC4350SS000058', 'Mac', 'Streamliner', '2/23/2016', '7/14/2022', 1, Null),
('JH4KA4550JC048596', 'Peterbilt', 'Freighthauler', '10/18/2018', '11/28/2021', 1, Null),
('5NPEC4AC5BH041176', 'Ford', 'Roadmaster', '12/4/1961', '4/13/2022', 2, 20);
GO

--2.4/2.5 Populate Terminals table
INSERT INTO Terminals
VALUES
('CTC', 'Chicago', 'IL', '1946', 18),
('PIH', 'Portland', 'OR', '1940', 12);
GO

--2.6/2.7 Populate Shipments table
INSERT INTO Shipments
VALUES
('5NPEC4AC5BH041176', 2, 'CTC', 'PIH', '10/22/2022 07:50', '10/22/2022 22:47'),
('JH4DC4350SS000058', 1, 'PIH', 'CTC', '7/29/2022 22:52', '7/31/2022 01:08');
GO

--3.1 CR England Trucks to Swift
UPDATE Trucks
SET CarrierID = 2
WHERE CarrierID = 1;
GO

--3.2 CR England Shipments to Swift
UPDATE Shipments
SET CarrierID = 2
WHERE CarrierID = 1;
GO

--4 Drop CR England
DELETE FROM Carriers
WHERE CarrierID = 1;
GO
