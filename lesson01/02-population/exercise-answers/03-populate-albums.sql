USE music;
GO

DECLARE @RollingStones  uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'The Rolling Stones');
DECLARE @BBKingBand     uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'B.B. King Band');
DECLARE @MilesDavis     uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Miles Davis Quartet');
DECLARE @Metallica      uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Metallica');
DECLARE @LedZeppelin    uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Led Zeppelin');
DECLARE @MuddyWaters    uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Muddy Waters Band');
DECLARE @Coltrane       uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'John Coltrane Quartet');
DECLARE @BlackSabbath   uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Black Sabbath');
DECLARE @ACDC           uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'AC/DC');

INSERT INTO Album
    (Name, ReleaseYear, CopiesSold, MusicGroupId)
VALUES
    ('Sticky Fingers',           1971,  8000000, @RollingStones),
    ('Exile on Main St.',        1972,  7000000, @RollingStones),
    ('Live at the Regal',        1965,  1000000, @BBKingBand),
    ('Kind of Blue',             1959,  5000000, @MilesDavis),
    ('Master of Puppets',        1986,  6000000, @Metallica),
    ('The Black Album',          1991, 16000000, @Metallica),
    ('Led Zeppelin IV',          1971, 37000000, @LedZeppelin),
    ('Physical Graffiti',        1975,  8000000, @LedZeppelin),
    ('The Best of Muddy Waters', 1958,   500000, @MuddyWaters),
    ('A Love Supreme',           1965,  1000000, @Coltrane),
    ('Paranoid',                 1970,  4000000, @BlackSabbath),
    ('Heaven and Hell',          1980,  3000000, @BlackSabbath),
    ('Back in Black',            1980, 50000000, @ACDC),
    ('Highway to Hell',          1979, 10000000, @ACDC),
    ('Ride the Lightning',       1984,  6000000, @Metallica),
    ('Houses of the Holy',       1973,  9000000, @LedZeppelin);
GO
