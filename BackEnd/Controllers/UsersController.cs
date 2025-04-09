using Microsoft.AspNetCore.Mvc;
using IntertenisClub.Models;
using IntertenisClub.BusinessLogic.Interfaces;
using System.Security.Cryptography;
using System.Text;

namespace IntertenisClub.Controllers;

[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;

    public UsersController(IUserService userService)
    {
        _userService = userService;
    }

    // Endpoint para registro de usuarios
    [HttpPost("register")]
    public async Task<IActionResult> Register(RegisterDto registerDto)
    {
        var result = await _userService.RegisterUserAsync(registerDto);

        if (!result.Succeeded)
            return BadRequest(result.Message);

        return Ok(result);
    }

    [HttpGet]
    public async Task<List<User>> Get() =>
        await _userService.GetAllUsersAsync();

    [HttpGet("{id}")]
    public async Task<ActionResult<User>> Get(string id)
    {
        var user = await _userService.GetUserByIdAsync(id);
        return user is null ? NotFound() : user;
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(string id, User updatedUser)
    {
        await _userService.UpdateUserAsync(id, updatedUser);
        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(string id)
    {
        await _userService.DeleteUserAsync(id);
        return NoContent();
    }
     
}