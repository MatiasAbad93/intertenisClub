using IntertenisClub.Models;
using MongoDB.Driver;
using System.Threading.Tasks;
using System.Collections.Generic;
using IntertenisClub.Repository.Interfaces;

namespace IntertenisClub.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly IMongoCollection<User> _users;

        public UserRepository(IMongoDatabase database)
        {
            _users = database.GetCollection<User>("Users");
        }

        public async Task<List<User>> GetAllAsync() =>
            await _users.Find(_ => true).ToListAsync();

        public async Task<User?> GetByIdAsync(string id) =>
            await _users.Find(x => x.Id == id).FirstOrDefaultAsync();

        public async Task<User?> GetByUsernameAsync(string username) =>
            await _users.Find(x => x.Username == username).FirstOrDefaultAsync();

        public async Task<User?> GetByDniAsync(string dni) =>
            await _users.Find(x => x.DNI == dni).FirstOrDefaultAsync();

        public async Task<User?> GetByEmailAsync(string email) =>
            await _users.Find(x => x.Email == email).FirstOrDefaultAsync();

        public async Task CreateAsync(User user) =>
            await _users.InsertOneAsync(user);

        public async Task UpdateAsync(string id, User user) =>
            await _users.ReplaceOneAsync(x => x.Id == id, user);

        public async Task DeleteAsync(string id) =>
            await _users.DeleteOneAsync(x => x.Id == id);

        public async Task<bool> UserExists(string username, string email)
        {
            var filter = Builders<User>.Filter.Or(
                Builders<User>.Filter.Eq(x => x.Username, username),
                Builders<User>.Filter.Eq(x => x.Email, email)
            );
            return await _users.Find(filter).AnyAsync();
        }
    }
}