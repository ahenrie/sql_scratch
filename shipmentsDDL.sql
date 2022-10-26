-- A carrier is a commercial trucking company offering shipments from one terminal to another
CREATE TABLE Carriers (
CarrierID INTEGER PRIMARY KEY IDENTITY(1,1),
CarrierName VARCHAR(20)
);
GO

-- One carrier will own and operate many trucks of various kinds
CREATE TABLE Trucks (
VIN  CHAR(17) PRIMARY KEY,
Manufacturer VARCHAR(20),
Model VARCHAR(25),
DatePurchased DATE,
LastServiceDate DATE,
CarrierID INT REFERENCES Carriers(CarrierID),
HaulingCap INT
);
GO

-- There are many trucking terminals throughout the country
CREATE TABLE Terminals (
TerminalCode CHAR(3) PRIMARY KEY,
TerminalCity VARCHAR(25),
TerminalState CHAR(2),
YearOpened INT,
NumberOfDocks INT
);
GO

-- There are many shipments. Each shipment originates at one terminal and ends at a different one. Each shipment is completed by one company using one truck.
CREATE TABLE Shipments (
ShipmentID INT PRIMARY KEY IDENTITY(1000,1),
VIN CHAR(17) REFERENCES Trucks(VIN),
CarrierID INT REFERENCES Carriers(CarrierID),
DepartCode CHAR(3) REFERENCES Terminals(TerminalCode),
ArriveCode CHAR(3) REFERENCES Terminals(TerminalCode),
DepartDateTime DATETIME,
ArriveDateTime DATETIME
);
GO
