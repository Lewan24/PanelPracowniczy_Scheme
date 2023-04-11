using Microsoft.AspNetCore.Mvc;
using PP.Shared.Entities;

namespace PP.Server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TestController : ControllerBase
{
    [HttpGet]
    public ActionResult<TestModel> Get()
    {
        return Ok(new TestModel("Dziala!!", 2));
    }
}