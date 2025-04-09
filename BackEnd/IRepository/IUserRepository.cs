using IntertenisClub.Models;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace IntertenisClub.Repository.Interfaces
{
    public interface IUserRepository
    {
        Task<List<User>> GetAllAsync();
        Task<User?> GetByIdAsync(string id);
        Task<User?> GetByUsernameAsync(string username);
        Task<User?> GetByDniAsync(string dni);
        Task<User?> GetByEmailAsync(string email);
        Task CreateAsync(User user);
        Task UpdateAsync(string id, User user);
        Task DeleteAsync(string id);
        Task<bool> UserExists(string username, string email);
    }
}