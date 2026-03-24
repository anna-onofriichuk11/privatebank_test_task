using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

await Host.CreateDefaultBuilder(args)
    .ConfigureServices(s =>
    {
        s.AddHostedService<InsertWorker>();
    })
    .RunConsoleAsync();
