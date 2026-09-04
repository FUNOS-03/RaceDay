-- RaceDay Database Script

-- This script creates the database tables, relationships,
-- constraints and sample data for the RaceDay system.
CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20),
    Role NVARCHAR(20) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_User_Role
        CHECK (Role IN ('Organiser', 'Participant'))
);
CREATE TABLE Event (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID INT NOT NULL,
    EventName NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500),
    EventDate DATE NOT NULL,
    Location NVARCHAR(150) NOT NULL,
    RegistrationDeadline DATE NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (OrganiserID) REFERENCES [User](UserID)
);
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryName NVARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL,
    MaximumParticipants INT NOT NULL,

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventID) REFERENCES Event(EventID)
);
CREATE TABLE Enrolment (
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID INT NOT NULL,
    CategoryID INT NOT NULL,
    EnrolmentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    EmergencyContactName NVARCHAR(100) NOT NULL,
    EmergencyContactPhone NVARCHAR(20) NOT NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT FK_Enrolment_Participant
        FOREIGN KEY (ParticipantID) REFERENCES [User](UserID),

    CONSTRAINT FK_Enrolment_Category
        FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),

    CONSTRAINT CK_Enrolment_Status
        CHECK (Status IN ('Active', 'Cancelled', 'Completed'))
);
CREATE TABLE Result (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL,
    FinishTime TIME,
    Position INT,
    AveragePace DECIMAL(6,2),
    ResultStatus NVARCHAR(20) NOT NULL DEFAULT 'Completed',
    RecordedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentID) REFERENCES Enrolment(EnrolmentID),

    CONSTRAINT CK_Result_Status
        CHECK (ResultStatus IN ('Completed', 'DNF', 'DNS'))
);
CREATE TABLE Route (
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    RouteName NVARCHAR(150) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    ElevationGain DECIMAL(8,2),
    MapUrl NVARCHAR(500),
    Description NVARCHAR(500),

    CONSTRAINT FK_Route_Event
        FOREIGN KEY (EventID) REFERENCES Event(EventID)
);
CREATE TABLE Weather (
    WeatherID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    ForecastDate DATE NOT NULL,
    Temperature DECIMAL(5,2),
    WeatherCondition NVARCHAR(100),
    WindSpeed DECIMAL(6,2),
    RainProbability DECIMAL(5,2),

    CONSTRAINT FK_Weather_Event
        FOREIGN KEY (EventID) REFERENCES Event(EventID)
);
CREATE TABLE EventImage (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    ImageUrl NVARCHAR(500),
    BlobName NVARCHAR(255),
    UploadedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_EventImage_Event
        FOREIGN KEY (EventID) REFERENCES Event(EventID)
);




INSERT INTO [User]
    (FirstName, LastName, Email, PasswordHash, PhoneNumber, Role)
VALUES
    ('Thabo', 'Mokoena', 'thabo.mokoena@raceday.co.za', 'PasswordHash1', '0821112233', 'Organiser'),
    ('Lerato', 'Nkosi', 'lerato.nkosi@raceday.co.za', 'PasswordHash2', '0832223344', 'Organiser');
   

INSERT INTO [User]
    (FirstName, LastName, Email, PasswordHash, PhoneNumber, Role)
VALUES
    ('Sipho', 'Dlamini', 'sipho.dlamini@raceday.co.za', 'PasswordHash3', '0843334455', 'Participant'),
    ('Nomsa', 'Khumalo', 'nomsa.khumalo@raceday.co.za', 'PasswordHash4', '0854445566', 'Participant');
   
INSERT INTO Event
    (OrganiserID, EventName, Description, EventDate, Location, RegistrationDeadline)
VALUES
    (1, 'Pretoria City Run', 'A road running event through Pretoria.', '2026-10-10', 'Pretoria, Gauteng', '2026-10-01'),
    (1, 'Johannesburg Cycle Challenge', 'A cycling event for road cycling enthusiasts.', '2026-11-15', 'Johannesburg, Gauteng', '2026-11-05'),
    (2, 'Cape Town Coastal Walk', 'A scenic walking event along the Cape Town coastline.', '2026-12-05', 'Cape Town, Western Cape', '2026-11-25');
    
INSERT INTO Category
    (EventID, CategoryName, DistanceKm, EntryFee, MaximumParticipants)
VALUES
    (1, '10km Run', 10.00, 150.00, 500),
    (1, '5km Fun Run', 5.00, 100.00, 300),
    (2, '50km Cycle', 50.00, 250.00, 400),
    (2, '100km Cycle', 100.00, 350.00, 300),
    (3, '10km Coastal Walk', 10.00, 120.00, 350),
    (3, '5km Family Walk', 5.00, 80.00, 250);
   
INSERT INTO Enrolment
    (ParticipantID, CategoryID, EmergencyContactName, EmergencyContactPhone, Status)
VALUES
    (3, 1, 'Maria Dlamini', '0861112233', 'Active'),
    (4, 2, 'John Khumalo', '0872223344', 'Active'),
    (3, 3, 'Maria Dlamini', '0861112233', 'Active'),
    (4, 5, 'John Khumalo', '0872223344', 'Active');
    
INSERT INTO Result
    (EnrolmentID, FinishTime, Position, AveragePace, ResultStatus)
VALUES
    (1, '00:58:32', 45, 5.85, 'Completed'),
    (2, '00:32:15', 28, 6.45, 'Completed');
    
INSERT INTO Route
    (EventID, RouteName, DistanceKm, ElevationGain, MapUrl, Description)
VALUES
    (1, 'Pretoria City Route', 10.00, 120.00, 'https://example.com/pretoria-route', 'Road running route through Pretoria.'),
    (2, 'Johannesburg Cycle Route', 50.00, 450.00, 'https://example.com/johannesburg-route', 'Road cycling route through Johannesburg.'),
    (3, 'Cape Town Coastal Route', 10.00, 80.00, 'https://example.com/cape-town-route', 'Scenic walking route along the Cape Town coastline.');


INSERT INTO Weather
    (EventID, ForecastDate, Temperature, WeatherCondition, WindSpeed, RainProbability)
VALUES
    (1, '2026-10-10', 22.00, 'Sunny', 12.00, 10.00),
    (2, '2026-11-15', 24.00, 'Partly Cloudy', 18.00, 20.00),
    (3, '2026-12-05', 21.00, 'Clear', 10.00, 5.00);
  

INSERT INTO EventImage
    (EventID, ImageUrl, BlobName)
VALUES
    (1, 'https://example.com/images/pretoria-city-run.jpg', 'pretoria-city-run.jpg'),
    (2, 'https://example.com/images/johannesburg-cycle.jpg', 'johannesburg-cycle.jpg'),
    (3, 'https://example.com/images/cape-town-coastal-walk.jpg', 'cape-town-coastal-walk.jpg');
