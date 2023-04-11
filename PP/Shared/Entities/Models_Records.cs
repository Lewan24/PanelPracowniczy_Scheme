namespace PP.Shared.Entities;

public record TestModel (string? Name, int Age = 0);
public record Module(string name, string desc, string link, MudBlazor.Color color, bool isDisabled);
public record ModuleMenu(string moduleName, List<(string link, string icon)> links);