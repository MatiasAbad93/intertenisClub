// IPasswordHasher.cs
namespace IntertenisClub.Helpers
{
    public interface IPasswordHasher
    {
        (string Hash, string Salt) CreateHash(string password);
        bool VerifyPassword(string password, string hash, string salt);
    }
}