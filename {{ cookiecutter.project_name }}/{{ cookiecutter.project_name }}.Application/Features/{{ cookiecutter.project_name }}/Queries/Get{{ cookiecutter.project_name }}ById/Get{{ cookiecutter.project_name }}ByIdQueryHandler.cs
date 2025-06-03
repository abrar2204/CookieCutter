using MediatR;

namespace {{ cookiecutter.project_name }}.Application.Features.{{ cookiecutter.project_name }}.Queries.Get{{ cookiecutter.project_name }}ById;

public class Get{{ cookiecutter.project_name }}ByIdQueryHandler : IRequestHandler<Get{{ cookiecutter.project_name }}ByIdQuery, Get{{ cookiecutter.project_name }}ByIdQueryResponse>
{
    public Task<Get{{ cookiecutter.project_name }}ByIdQueryResponse> Handle(Get{{ cookiecutter.project_name }}ByIdQuery request, CancellationToken cancellationToken)
    {
        throw new NotImplementedException();
    }
}