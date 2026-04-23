# Lesson 06 – Exercises: ERD Modelling

---

## Exercise 1 – Design an ER diagram for the Music database

**Task:**

Using **crow's foot notation**, draw an Entity-Relationship (ER) diagram for a relational Music database based on the following C# model classes.

**C# models:**

```csharp
public class Artist
{
    public Guid ArtistId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public DateTime? BirthDay { get; set; }

    public List<MusicGroup> MusicGroups { get; set; }
}

public enum MusicGenre { Rock, Blues, Jazz, Metal }
public class MusicGroup
{
    public Guid MusicGroupId { get; set; }
    public string Name { get; set; }
    public int EstablishedYear { get; set; }
    public MusicGenre Genre { get; set; }

    public List<Album> Albums { get; set; }
    public List<Artist> Artists { get; set; }
}

public class Album
{
    public Guid AlbumId { get; set; }
    public string Name { get; set; }
    public int ReleaseYear { get; set; }
    public long CopiesSold { get; set; }

    public MusicGroup MusicGroup { get; set; }
}
```

**Steps:**

1. Identify all **entities** (tables) from the classes above.
2. Identify the **primary key** and **attributes** for each entity.
3. Identify the **relationships** between entities:
   - What is the relationship between `Artist` and `MusicGroup`?
   - What is the relationship between `MusicGroup` and `Album`?
   - Does any relationship require a **junction / bridge table**? If so, include it.
4. For each relationship, determine the **cardinality** (one-to-one, one-to-many, many-to-many) and mark it using crow's foot notation.
5. Draw the diagram using one of the following tools:
   - [Lucidchart](https://www.lucidchart.com) (free account)
   - [draw.io / diagrams.net](https://app.diagrams.net) (free, no account needed)
   - Pencil and paper

**Hints:**

- A `List<T>` navigation property on both sides of a relationship indicates a **many-to-many** relationship, which requires a junction table in a relational database (e.g. `ArtistMusicGroup`).
- A single navigation property (not a list) on one side indicates a **many-to-one / one-to-many** relationship.
- Use `Guid` columns as primary keys. Foreign keys reference the PK of the related table.
- `MusicGenre` is an enum — store it as an `INT` or `NVARCHAR` column in the database.

**Expected outcome:**

Your diagram should contain **four entities**:

| Entity | Key columns |
|---|---|
| `Artist` | `ArtistId` (PK), `FirstName`, `LastName`, `BirthDay` |
| `MusicGroup` | `MusicGroupId` (PK), `Name`, `EstablishedYear`, `Genre` |
| `Album` | `AlbumId` (PK), `Name`, `ReleaseYear`, `CopiesSold`, `MusicGroupId` (FK) |
| `ArtistMusicGroup` | `ArtistId` (FK), `MusicGroupId` (FK) |

Relationships:
- `Artist` ↔ `MusicGroup`: many-to-many (via `ArtistMusicGroup`)
- `MusicGroup` → `Album`: one-to-many (one group has many albums)

---

## Exercise 2 – Explore existing ER diagrams in SSMS or DBeaver

**Task:**

Using **DBeaver**, open the built-in ER diagram / database diagram tool for each of the following databases and explore their structure.

**Databases to investigate:**

1. **`friends`** – a small relational database modelled from the C# `Friend`, `Address`, `Pet`, and `Quote` classes.
2. **`sakila`** – a sample movie rental database with many interconnected tables.

**Steps:**

1. Connect to your SQL Server instance in DBeaver.
2. For the **`friends`** database:
   - Open the database diagram (DBeaver: right-click schema → *ER Diagram*).
   - Identify all tables and their columns.
   - For each relationship (foreign key), note:
     - Which table holds the foreign key?
     - Which table is the parent (referenced)?
     - What is the cardinality (one-to-one, one-to-many, many-to-many)?
3. Repeat step 2 for the **`sakila`** database.
4. Discuss the following questions:
   - Which tables in `sakila` have the most relationships?
   - Are there any many-to-many relationships? How are they resolved?
   - What naming conventions are used for primary keys and foreign keys?

**Hints:**

- In **DBeaver**, right-click on a schema name and choose *View Diagram* or *ER Diagram* to generate an automatic diagram.
- Look at the foreign key arrows — the "many" end points to the child table (the one holding the FK column).

**Expected outcome:**

- For `friends`: you should be able to map the diagram back to the C# classes (`Friend`, `Address`, `Pet`, `Quote`) and verify each relationship matches the navigation properties.
- For `sakila`: you should identify the core tables (`film`, `actor`, `customer`, `rental`, `payment`, `inventory`, etc.) and trace how a rental links a customer, a film copy, and a payment together.
- You can articulate the cardinality of at least three relationships in each database.
