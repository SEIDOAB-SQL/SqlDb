# Lesson 05 – Exercises: XML

Use the `music` database for all exercises.

The database has four tables:

| Table | Key columns |
|---|---|
| `Artist` | `ArtistId`, `FirstName`, `LastName`, `BirthDay` |
| `MusicGroup` | `MusicGroupId`, `Name`, `EstablishedYear`, `Genre` |
| `Album` | `AlbumId`, `Name`, `ReleaseYear`, `CopiesSold`, `MusicGroupId` |
| `ArtistMusicGroup` | `ArtistId`, `MusicGroupId` |

---

## Exercise 1 – FOR XML AUTO

**Task:** Write a query that returns music group and album data as XML using `FOR XML AUTO`. Join `MusicGroup` to `Album` and return all columns. The XML element names should be derived automatically from the table aliases.

Then store the result in an `XML` variable called `@musicXML` and display it with a `SELECT`.

**Hint:** Use `FOR XML AUTO` at the end of the query. To assign to a variable, wrap the query in `SET @musicXML = (SELECT ... FOR XML AUTO)`.

**Expected outcome:** An XML document where each `MusicGroup` element contains nested `Album` child elements for every album belonging to that group.

**Answer:** [02-xml.sql](../exercise-answers/02-xml.sql)

---

## Exercise 2 – FOR XML PATH

**Task:** Write a query that produces a structured XML output using `FOR XML PATH('MusicGroup')`. For each music group, include:

| XML output | Source |
|---|---|
| `@MusicGroupId` attribute | `MusicGroup.MusicGroupId` |
| `Name` element | `MusicGroup.Name` |
| `Genre` element | `MusicGroup.Genre` |
| `EstablishedYear` element | `MusicGroup.EstablishedYear` |
| `Album` element | `Album.Name` and `Album.ReleaseYear` formatted as `'<AlbumName> (<ReleaseYear>)'` |

Join `MusicGroup` to `Album`. Use `CONCAT` or string concatenation to format the `Album` element value.

**Hint:** Use column aliases with `/` notation to control element nesting, e.g. `mg.Name "Name"`. Prefix an alias with `@` to make it an XML attribute.

**Expected outcome:** One `<MusicGroup>` element per album row, each carrying the group's details and a formatted album description.

**Answer:** [02-xml.sql](../exercise-answers/02-xml.sql)
