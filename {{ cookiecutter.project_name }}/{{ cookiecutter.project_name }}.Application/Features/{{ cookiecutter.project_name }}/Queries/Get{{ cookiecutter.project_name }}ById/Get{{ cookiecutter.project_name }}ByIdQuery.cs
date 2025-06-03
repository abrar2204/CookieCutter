using MediatR;

namespace {{ cookiecutter.project_name }}.Application.Features.{{ cookiecutter.project_name }}.Queries.Get{{ cookiecutter.project_name }}ById;

public class Get{{ cookiecutter.project_name }}ByIdQuery : IRequest<Get{{ cookiecutter.project_name }}ByIdQueryResponse>
{
    public int {{ cookiecutter.project_name }}Id { get; set; }
}