using IntertenisClub.Models;
using IntertenisClub.Repository;
using IntertenisClub.BusinessLogic;
using IntertenisClub.Repository.Interfaces;
using IntertenisClub.BusinessLogic.Interfaces;
using MongoDB.Driver;

var builder = WebApplication.CreateBuilder(args);

// 1. Configuración de MongoDB
var mongoSettings = builder.Configuration.GetSection("MongoDB");
var client = new MongoClient(mongoSettings["ConnectionString"]);
var database = client.GetDatabase(mongoSettings["DatabaseName"]);

// 2. Registro de dependencias (¡orden jerárquico!)
builder.Services.AddSingleton<IMongoDatabase>(database); // Base de datos MongoDB
builder.Services.AddScoped<IUserRepository, UserRepository>(); // Capa Repository
builder.Services.AddScoped<IUserService, UserService>(); // Capa BusinessLogic

// 3. Configuración de la API
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// 4. Middlewares
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapControllers();
app.Run();