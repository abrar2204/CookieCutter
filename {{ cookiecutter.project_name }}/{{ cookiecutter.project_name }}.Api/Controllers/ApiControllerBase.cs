using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Infrastructure;

namespace {{ cookiecutter.project_name }}.Api.Controllers;

[Authorize]
[ApiController]
[Produces("application/json")]
public abstract class ApiControllerBase : ControllerBase
{
    protected readonly IMediator mediator;

    protected ApiControllerBase(IMediator mediator)
    {
        this.mediator = mediator;
    }
    
    [NonAction]
    protected ObjectResult CreatedResult([ActionResultObjectValue] object value)
        => new(value) { StatusCode = StatusCodes.Status201Created };
}
