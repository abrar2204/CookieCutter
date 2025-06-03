using System.ComponentModel.DataAnnotations;
using {{ cookiecutter.project_name }}.Api.Attribute;
using {{ cookiecutter.project_name }}.Application.Features.{{ cookiecutter.project_name }}.Commands.Create{{ cookiecutter.project_name }};
using {{ cookiecutter.project_name }}.Application.Features.{{ cookiecutter.project_name }}.Queries.Get{{ cookiecutter.project_name }}ById;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace {{ cookiecutter.project_name }}.Api.Controllers;

public class {{ cookiecutter.project_name }}Controller : ApiControllerBase
{
    public {{ cookiecutter.project_name }}Controller(IMediator mediator) : base(mediator)
    {
    }
    
    [HttpGet("{id:int}")]
    [ApiOperation("Get {{ cookiecutter.project_name }} Details")]
    [ApiSuccessResponse(200, "{{ cookiecutter.project_name }} information for the provided {{ cookiecutter.project_name }} id", typeof(Get{{ cookiecutter.project_name }}ByIdQueryResponse))]
    [ApiErrorResponse(404, "{{ cookiecutter.project_name }} for provided id doesn't exist")]
    public async Task<IActionResult> Get{{ cookiecutter.project_name }}Details([FromRoute] [Required] int id) =>
        Ok(await mediator.Send(new Get{{ cookiecutter.project_name }}ByIdQuery { {{ cookiecutter.project_name }}Id = id }));

    [HttpPost]
    [ApiOperation("Creates a new {{ cookiecutter.project_name }}")]
    [ApiSuccessResponse(201, "The created {{ cookiecutter.project_name }}", typeof(Create{{ cookiecutter.project_name }}CommandResponse))]
    [ApiErrorResponse(400, "Input request has invalid values")]
    public async Task<IActionResult> Create{{ cookiecutter.project_name }}([FromBody, Required] Create{{ cookiecutter.project_name }}Command command) =>
        CreatedResult(await mediator.Send(command));
}