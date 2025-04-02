using IntertenisClub.Models;
using IntertenisClub.Repository.Interfaces;
using IntertenisClub.BusinessLogic.Interfaces;

namespace IntertenisClub.BusinessLogic;

public class UserService : IUserService
{
    private readonly IUserRepository _userRepository;

    public UserService(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<List<User>> GetAllUsersAsync() =>
        await _userRepository.GetAllAsync();

    public async Task<User?> GetUserByIdAsync(string id) =>
        await _userRepository.GetByIdAsync(id);

    public async Task CreateUserAsync(User user)
    {
        // Validaciones de negocio (ej: DNI único)
        await _userRepository.CreateAsync(user);
    }

    public async Task UpdateUserAsync(string id, User user) =>
        await _userRepository.UpdateAsync(id, user);

    public async Task DeleteUserAsync(string id) =>
        await _userRepository.DeleteAsync(id);
}