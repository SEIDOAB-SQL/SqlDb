namespace Models;

public enum AnimalKind { Dog, Cat, Rabbit, Fish, Bird };
public enum AnimalMood { Happy, Hungry, Lazy, Sulky, Buzy, Sleepy };
public class Pet
{
    //Individual Id
    public Guid PetId { get; set; }

    //Model properties
    public AnimalKind AnimalKind { get; set; }
    public AnimalMood AnimalMood { get; set; }
    public string Name { get; set; }

    //Model relationships
    public Friend Owner { get; set; }
}