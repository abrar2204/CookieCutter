using MediatR;

namespace {{ cookiecutter.project_name }}.Application.Features.{{ cookiecutter.project_name }}.Commands.Create{{ cookiecutter.project_name }};

public class Create{{ cookiecutter.project_name }}CommandHandler : IRequestHandler<Create{{ cookiecutter.project_name }}Command, Create{{ cookiecutter.project_name }}CommandResponse>
{
    public Task<Create{{ cookiecutter.project_name }}CommandResponse> Handle(Create{{ cookiecutter.project_name }}Command request, CancellationToken cancellationToken)
    {
        throw new NotImplementedException();
    }
}