using System.ComponentModel.DataAnnotations;

namespace IntertenisClub.Models;

public class RegisterDto
{
    [Required]
    public string Username { get; set; } = null!;

    [Required]
    [StringLength(100, MinimumLength = 6)]
    public string Password { get; set; } = null!;

    [Required]
    [EmailAddress]
    public string Email { get; set; } = null!;

    [Required]
    public string Nombre { get; set; } = null!;

    [Required]
    public string Apellido { get; set; } = null!;

    [Required]
    public string DNI { get; set; } = null!;

    [Required]
    public DateTime FechaNacimiento { get; set; }
}