using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using ScaleTestEndpoint;
using System;

[assembly: FunctionsStartup(typeof(Startup))]
namespace ScaleTestEndpoint
{
    public class Startup
        : FunctionsStartup
    {
        public override void Configure(IFunctionsHostBuilder builder)
        {
            _ = builder ?? throw new ArgumentNullException(nameof(builder));
        }
    }
}
