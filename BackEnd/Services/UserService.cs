using IntertenisClub.BusinessLogic.DTOs;
using IntertenisClub.Models;
using IntertenisClub.Repository.Interfaces;
using IntertenisClub.Helpers;
using System.Text;
using System.Threading.Tasks;
using System.Collections.Generic;
using IntertenisClub.BusinessLogic.Interfaces;
using Microsoft.AspNetCore.Identity;

namespace IntertenisClub.BusinessLogic.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IPasswordHasher _passwordHasher;

        public UserService(IUserRepository userRepository, IPasswordHasher passwordHasher)
        {
            _userRepository = userRepository;
            _passwordHasher = passwordHasher;
        }

        public async Task<ServiceResult> RegisterUserAsync(RegisterDto registerDto)
        {
            if (await _userRepository.UserExists(registerDto.Username, registerDto.Email))
                return ServiceResult.Failure("El usuario o email ya existe");

            var (passwordHash, salt) = _passwordHasher.CreateHash(registerDto.Password);

            var user = new User
            {
                Username = registerDto.Username,
                Password = passwordHash,
                Salt = salt,
                Email = registerDto.Email,
                Nombre = registerDto.Nombre,
                Apellido = registerDto.Apellido,
                DNI = registerDto.DNI,
                FechaNacimiento = registerDto.FechaNacimiento,
                Rol = "Usuario"
            };

            await _userRepository.CreateAsync(user);

            return ServiceResult.Success("Usuario registrado exitosamente");
        }

        // Implementación de otros métodos del servicio...
        public async Task<List<User>> GetAllUsersAsync() =>
            await _userRepository.GetAllAsync();

        public async Task<User?> GetUserByIdAsync(string id) =>
            await _userRepository.GetByIdAsync(id);

        public async Task UpdateUserAsync(string id, User user) =>
            await _userRepository.UpdateAsync(id, user);

        public async Task DeleteUserAsync(string id) =>
            await _userRepository.DeleteAsync(id);
    }
}