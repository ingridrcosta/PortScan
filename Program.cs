var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/scan/{ipRede}/{mascara}/{inicio}/{fim}", async context =>
{
    var ipRede = context.Request.RouteValues["ipRede"];
    var mascaraIP = context.Request.RouteValues["mascara"];
    var portaInicio = context.Request.RouteValues["inicio"];
    var portaFim = context.Request.RouteValues["fim"];
    

    System.Diagnostics.ProcessStartInfo process = new System.Diagnostics.ProcessStartInfo();
    process.UseShellExecute = false;
    process.WorkingDirectory = "/bin";
    process.FileName = "bash";
    process.Arguments = $"/home/lain/PUC/NetCatScanner/portscanner.sh {ipRede} {mascaraIP} {portaInicio} {portaFim}";
    process.RedirectStandardOutput = true;

    using (System.Diagnostics.Process cmd = System.Diagnostics.Process.Start(process))
    {
        cmd.WaitForExit();
    }

    string logContent = await System.IO.File.ReadAllTextAsync("/home/lain/PUC/NetCatScanner/scan/log.txt");

    context.Response.ContentType = "text/plain"; 
    await context.Response.WriteAsync($"IP da rede: {ipRede}/{mascaraIP} e {portaInicio} e {portaFim}.\n");
    await context.Response.WriteAsync(logContent);
});

app.Run();
