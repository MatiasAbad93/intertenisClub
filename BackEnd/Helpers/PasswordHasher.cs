using System.Security.Cryptography;
using System.Text;

namespace IntertenisClub.Helpers
{
    public interface IPasswordHasher
    {
        (string Hash, string Salt) CreateHash(string password);
    }

    public class PasswordHasher : IPasswordHasher
    {
        public (string Hash, string Salt) CreateHash(string password)
        {
            using var hmac = new HMACSHA512();
            var passwordHash = hmac.ComputeHash(Encoding.UTF8.GetBytes(password));
            var passwordSalt = hmac.Key;

            return (
                Hash: Convert.ToBase64String(passwordHash),
                Salt: Convert.ToBase64String(passwordSalt)
            );
        }
    }
}