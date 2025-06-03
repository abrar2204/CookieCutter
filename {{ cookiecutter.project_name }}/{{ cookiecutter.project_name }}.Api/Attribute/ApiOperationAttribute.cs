using Swashbuckle.AspNetCore.Annotations;

namespace {{ cookiecutter.project_name }}.Api.Attribute
{
    /// <summary>
    /// Abstraction over default swagger attrs  
    /// </summary>
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = false, Inherited = true)]
    public class ApiOperationAttribute : SwaggerOperationAttribute
    {
        public ApiOperationAttribute(string summary = null, string description = null)
            : base(summary, description)
        {
        }
    }
}