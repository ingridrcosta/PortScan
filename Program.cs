var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/scan/{IPRede}/{PortaInicial}/{PortaFinal}", async context  =>
{
    var IPRede = context.Request.RouteValues["IPRede"];
    var PortaInicial = context.Request.RouteValues["PortaInicial"];
    var PortaFinal = context.Request.RouteValues["PortaFinal"];

    System.Diagnostics.ProcessStartInfo process = new System.Diagnostics.ProcessStartInfo();
    process.UseShellExecute = false;
    process.WorkingDirectory = "/bin";
    process.FileName = "bash";
    process.Arguments = $"/$HOME/ScannerPort/portscanner.sh {IPRede} {PortaInicial} {PortaFinal}";

    using (System.Diagnostics.Process cmd = System.Diagnostics.Process.Start(process))
    {
        cmd.WaitForExit();
    }

    string logContent = await System.IO.File.ReadAllTextAsync("$HOME/ScannerPort//log.txt");

    context.Response.ContetType = "text/plain";
    await context.Response.WriteAsync($"IP da Rede: {IPRede}. Portas de: {PortaInicial}. Ate: {PortaFinal}.\n");
    await context.Response.WriteAsync(logContent);
});

app.Run();
