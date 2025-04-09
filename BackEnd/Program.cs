using IntertenisClub.Repository;
using IntertenisClub.Repository.Interfaces;
using IntertenisClub.BusinessLogic.Interfaces;
using MongoDB.Driver;
using IntertenisClub.BusinessLogic.Services;
using IntertenisClub.Helpers;

var builder = WebApplication.CreateBuilder(args);

// Configuración de MongoDB
var mongoSettings = builder.Configuration.GetSection("MongoDB");
var client = new MongoClient(mongoSettings["ConnectionString"]);
var database = client.GetDatabase(mongoSettings["DatabaseName"]);

// Registro de dependencias (¡orden jerárquico!)
builder.Services.AddSingleton<IMongoDatabase>(database); // Base de datos MongoDB
builder.Services.AddScoped<IPasswordHasher, PasswordHasher>(); // Password hasher
builder.Services.AddScoped<IUserRepository, UserRepository>(); // Capa Repository
builder.Services.AddScoped<IUserService, UserService>(); // Capa BusinessLogic



// Configuración CORS (permite conexiones desde Flutter)
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFlutterApp",
        policy =>
        {
            policy.WithOrigins(
                    "http://localhost", // Para Android emulador
                    "http://localhost:5500", // Para web
                    "http://10.0.2.2", // Para Android emulador (API local)
                    "http://127.0.0.1" // Alternativa
                )
                .AllowAnyHeader()
                .AllowAnyMethod();
        });
});

// Configuración de la API
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Middlewares
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseDeveloperExceptionPage();

}

app.UseCors("AllowFlutterApp");
app.MapControllers();
app.Run();