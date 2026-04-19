USE music;
GO

-- Artists
DECLARE @Mick    uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Mick'   AND LastName = 'Jagger');
DECLARE @Keith   uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Keith'  AND LastName = 'Richards');
DECLARE @BB      uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'B.B.'   AND LastName = 'King');
DECLARE @Miles   uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Miles'  AND LastName = 'Davis');
DECLARE @James   uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'James'  AND LastName = 'Hetfield');
DECLARE @Lars    uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Lars'   AND LastName = 'Ulrich');
DECLARE @Robert  uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Robert' AND LastName = 'Plant');
DECLARE @Jimmy   uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Jimmy'  AND LastName = 'Page');
DECLARE @Muddy   uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Muddy'  AND LastName = 'Waters');
DECLARE @John    uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'John'   AND LastName = 'Coltrane');
DECLARE @Ozzy    uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Ozzy'   AND LastName = 'Osbourne');
DECLARE @Tony    uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Tony'   AND LastName = 'Iommi');
DECLARE @Angus   uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Angus'  AND LastName = 'Young');
DECLARE @Brian   uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Brian'  AND LastName = 'Johnson');
DECLARE @Bon     uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Bon'    AND LastName = 'Scott');
DECLARE @Kirk    uniqueidentifier = (SELECT ArtistId FROM Artist WHERE FirstName = 'Kirk'   AND LastName = 'Hammett');

-- Music groups
DECLARE @RollingStones uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'The Rolling Stones');
DECLARE @BBKingBand    uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'B.B. King Band');
DECLARE @MilesDavis    uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Miles Davis Quartet');
DECLARE @Metallica     uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Metallica');
DECLARE @LedZeppelin   uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Led Zeppelin');
DECLARE @MuddyWaters   uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Muddy Waters Band');
DECLARE @Coltrane      uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'John Coltrane Quartet');
DECLARE @BlackSabbath  uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Black Sabbath');
DECLARE @ACDC          uniqueidentifier = (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'AC/DC');

INSERT INTO ArtistMusicGroup
    (ArtistId, MusicGroupId)
VALUES
    -- The Rolling Stones
    (@Mick,   @RollingStones),
    (@Keith,  @RollingStones),
    -- B.B. King leads his own band
    (@BB,     @BBKingBand),
    -- Miles Davis leads his own quartet
    (@Miles,  @MilesDavis),
    -- Metallica
    (@James,  @Metallica),
    (@Lars,   @Metallica),
    (@Kirk,   @Metallica),
    -- Led Zeppelin
    (@Robert, @LedZeppelin),
    (@Jimmy,  @LedZeppelin),
    -- Muddy Waters leads his own band
    (@Muddy,  @MuddyWaters),
    -- John Coltrane leads his own quartet
    (@John,   @Coltrane),
    -- Black Sabbath
    (@Ozzy,   @BlackSabbath),
    (@Tony,   @BlackSabbath),
    -- AC/DC — Bon Scott was the original singer, Brian Johnson replaced him
    (@Angus,  @ACDC),
    (@Brian,  @ACDC),
    (@Bon,    @ACDC);
GO
