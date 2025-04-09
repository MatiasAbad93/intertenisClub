// PasswordHasher.cs
using System.Security.Cryptography;
using System.Text;
using IntertenisClub.Helpers;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.AspNetCore.Identity;

namespace IntertenisClub.Helpers
{
    public class PasswordHasher : IPasswordHasher
    {
        public (string Hash, string Salt) CreateHash(string password)
        {
            // Generate a random salt
            var saltBytes = new byte[16];
            using var rng = RandomNumberGenerator.Create();
            rng.GetBytes(saltBytes);
            var salt = Convert.ToBase64String(saltBytes);

            // Create the hash
            var hashBytes = KeyDerivation.Pbkdf2(
                password: password,
                salt: Encoding.UTF8.GetBytes(salt),
                prf: KeyDerivationPrf.HMACSHA512,
                iterationCount: 10000,
                numBytesRequested: 32);

            var hash = Convert.ToBase64String(hashBytes);

            return (hash, salt);
        }

        public bool VerifyPassword(string password, string hash, string salt)
        {
            var hashBytes = Convert.FromBase64String(hash);
            var newHashBytes = KeyDerivation.Pbkdf2(
                password: password,
                salt: Encoding.UTF8.GetBytes(salt),
                prf: KeyDerivationPrf.HMACSHA512,
                iterationCount: 10000,
                numBytesRequested: 32);

            return CryptographicOperations.FixedTimeEquals(hashBytes, newHashBytes);
        }
    }
}