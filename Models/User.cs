using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace IntertenisClub.Models;

public class User
{
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string? Id { get; set; }

    [BsonElement("Nombre")]
    public string Nombre { get; set; } = null!;

    [BsonElement("Apellido")]
    public string Apellido { get; set; } = null!;

    [BsonElement("FechaNacimiento")]
    public DateTime FechaNacimiento { get; set; }

    [BsonElement("DNI")]
    public string DNI { get; set; } = null!;

}