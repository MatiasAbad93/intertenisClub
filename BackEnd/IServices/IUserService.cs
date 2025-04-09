using IntertenisClub.BusinessLogic.DTOs;
using IntertenisClub.Models;
using System.Threading.Tasks;

namespace IntertenisClub.BusinessLogic.Interfaces
{
    public interface IUserService
    {
        Task<ServiceResult> RegisterUserAsync(RegisterDto registerDto);
        Task<List<User>> GetAllUsersAsync();
        Task<User?> GetUserByIdAsync(string id);
        Task UpdateUserAsync(string id, User user);
        Task DeleteUserAsync(string id);
    }
}