using Microsoft.Extensions.Options;
using MongoDB.Driver;
using IntertenisClub.Models;

namespace IntertenisClub.Services;

public class MongoDBService
{
    private readonly IMongoCollection<User> _usersCollection;

    public MongoDBService(IOptions<MongoDBSettings> mongoDBSettings)
    {
        var client = new MongoClient(mongoDBSettings.Value.ConnectionString);
        var database = client.GetDatabase(mongoDBSettings.Value.DatabaseName);
        _usersCollection = database.GetCollection<User>(mongoDBSettings.Value.CollectionName);
    }

    // Obtener todos los usuarios
    public async Task<List<User>> GetAllUsers() =>
        await _usersCollection.Find(_ => true).ToListAsync();

    // Obtener un usuario por ID
    public async Task<User?> GetUserById(string id) =>
        await _usersCollection.Find(x => x.Id == id).FirstOrDefaultAsync();

    // Crear un nuevo usuario
    public async Task CreateUser(User newUser) =>
        await _usersCollection.InsertOneAsync(newUser);

    // Actualizar un usuario existente
    public async Task UpdateUser(string id, User updatedUser) =>
        await _usersCollection.ReplaceOneAsync(x => x.Id == id, updatedUser);

    // Eliminar un usuario
    public async Task DeleteUser(string id) =>
        await _usersCollection.DeleteOneAsync(x => x.Id == id);
}