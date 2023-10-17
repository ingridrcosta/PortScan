var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/scan/{iPRede}/{portaInicial}/{portaFinal}", async context  =>
{
    var iPRede = context.Request.RouteValues["iPRede"];
    var portaInicial = context.Request.RouteValues["portaInicial"];
    var portaFinal = context.Request.RouteValues["portaFinal"];

    System.Diagnostics.ProcessStartInfo process = new System.Diagnostics.ProcessStartInfo();
    process.UseShellExecute = false;
    process.WorkingDirectory = "/bin";
    process.FileName = "bash";
    process.Arguments = $"$HOME/ScannerPort/portscanner.sh {iPRede} {portaInicial} {portaFinal}";
    process.RedirectStandardOutput = true;

    using (System.Diagnostics.Process cmd = System.Diagnostics.Process.Start(process))
    {
        cmd.WaitForExit();
    }

    string logContent = await System.IO.File.ReadAllTextAsync("$HOME/ScannerPort/Logs/log.txt");

    context.Response.ContentType = "text/plain";
    await context.Response.WriteAsync($"IP da Rede: {iPRede}. Portas de: {portaInicial}. Ate: {portaFinal}.\n");
    await context.Response.WriteAsync(logContent);
});

app.Run();
