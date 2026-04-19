USE friends;
GO

DECLARE @Address1  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Svedjevägen 1');
DECLARE @Address2  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Frognerveien 10');
DECLARE @Address3  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Svanevej 7');
DECLARE @Address4  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Pohjoistranta 18');
DECLARE @Address5  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Vasagatan 3');
DECLARE @Address6  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Sågveien 5');
DECLARE @Address7  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Classensgade 9');
DECLARE @Address8  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Eerikinkatu 17');
DECLARE @Address9  uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Kungsgatan 12');
DECLARE @Address10 uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Drottninggatan 4');
DECLARE @Address11 uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Aker Brygge 2');
DECLARE @Address12 uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Strøget 8');
DECLARE @Address13 uniqueidentifier = (SELECT AddressId FROM Address WHERE StreetAddress = 'Mannerheimintie 5');

INSERT INTO Friend
    (FirstName, LastName, Email, Birthday, AddressId)
VALUES
    ('Harry',    'Took',       'harry.took@gmail.com',     '1990-03-14', @Address1),
    ('Severus',  'Gamgee',     'severus.gamgee@gmail.com', '1985-07-22', @Address2),
    ('Sam',      'Baggins',    'sam.baggins@gmail.com',    '1992-11-05', @Address3),
    ('Saruman',  'Malfoy',     'saruman.malfoy@gmail.com', NULL,         NULL),
    ('Lord',     'Dumbledore', NULL,                       '1978-01-30', @Address5),
    ('Hermione', 'Granger',    NULL,                       NULL,         @Address6),
    ('Albus',    'Potter',     'albus.potter@gmail.com',   '2001-06-18', @Address7),
    ('Draco',    'Snape',      'draco.snape@gmail.com',    NULL,         @Address8),
    ('Luna',     'Weasley',    'luna.weasley@gmail.com',   '1995-04-02', @Address9),
    ('Neville',  'Longbottom', 'neville.lb@gmail.com',     '1993-08-11', @Address10),
    ('Ginny',    'Lovegood',   NULL,                       NULL,         @Address11),
    ('Ron',      'Skywalker',  'ron.skywalker@gmail.com',  '1988-12-20', @Address12),
    ('Padma',    'Patil',      'padma.patil@gmail.com',    '1997-05-15', NULL);
GO