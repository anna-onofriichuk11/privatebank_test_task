using Dapper;
using Microsoft.Extensions.Hosting;
using Npgsql;

public class InsertWorker : BackgroundService
{
    private readonly connection_string =
        "Host=localhost;Port=5432;Database=test;Username=postgres;Password=reallyStrongPWD123";

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        await using var conn = new NpgsqlConnection(connection_string);

        while (!stoppingToken.IsCancellationRequested)
        {
            await conn.ExecuteAsync("select add_record();");
            await Task.Delay(TimeSpan.FromSeconds(5), stoppingToken);
        }
    }
}
