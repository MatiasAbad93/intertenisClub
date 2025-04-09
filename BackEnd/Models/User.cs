using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using System.ComponentModel.DataAnnotations;

namespace IntertenisClub.Models;

public class User
{
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string? Id { get; set; }

    [BsonElement("username")]
    [Required]
    public string Username { get; set; } = null!;

    [BsonElement("password")]
    [Required]
    public string Password { get; set; } = null!;

    [BsonElement("email")]
    [Required]
    [EmailAddress]
    public string Email { get; set; } = null!;

    [BsonElement("nombre")]
    [Required]
    public string Nombre { get; set; } = null!;

    [BsonElement("apellido")]
    [Required]
    public string Apellido { get; set; } = null!;

    [BsonElement("dni")]
    [Required]
    public string DNI { get; set; } = null!;

    [BsonElement("fechaNacimiento")]
    [Required]
    public DateTime FechaNacimiento { get; set; }

    [BsonElement("fechaCreacion")]
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;

    [BsonElement("rol")]
    public string Rol { get; set; } = "Usuario"; // Puede ser "Usuario" o "Admin"

    [BsonElement("salt")]
    public string Salt { get; set; } = null!; // Para almacenar la sal del hash

    [BsonElement("passwordResetToken")]
    public string? PasswordResetToken { get; set; }

    [BsonElement("resetTokenExpires")]
    public DateTime? ResetTokenExpires { get; set; }
}