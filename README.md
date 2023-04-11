This is simple scheme created for own purposes. Repo is on MIT licence, if anyone want use it for commercial purposes or for self, there you go.

Project has installed MudBlazor library. Its using .NET 7.
It uses external projects to use razor pages of each "module" in this mean like every module is a project with its own libraries, entities, logic, like another web app.

The project is built on Blazor WASM, so there is also Dockerfile that can be used to run this application on docker container.

If you want to do this you have to run on terminal while beeing in the same directory as dockerfile:
```bash
docker build . -t NAME_OF_IMAGE
example: docker build . -t blazor_pp_scheme
```

Then type:
```bash
docker run -dp PORT:80 NAME_OF_IMAGE
example: docker run -dp 5000:80 blazor_pp_scheme
```

If you use ssl:
```bash
docker run -dp PORT:80 -p PORT:443 NAME_OF_IMAGE
example: docker run -dp 5000:80 -p 5443:443 blazor_pp_scheme
```

If you want to add a new project you need to add reference to Client + copy command to dockerfile.
There is an example of additional assembiel in Client version:
```dotnet
App.razor

<Router AppAssembly="@typeof(App).Assembly" AdditionalAssemblies="@loadedAssemblies">
    <Found Context="routeData">
    
    ...
    
@code
{
    private List<Assembly> loadedAssemblies = new()
    {
        typeof(SystemZamowien.Index).Assembly,
        typeof(Usterki.Index).Assembly
        // Every project has to be here if you want to use the razor pages from these projects
        // typeof(PROJECT_NAME.Index).Assembly
    };
}

```

And the dockerfile, there you need to add the copy command to copy project to src in container.
In this example i use project named "Documents" as the one of the already added modules in app.
```dockerfile
Dockerfile

...

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

...

COPY ["FOLDER_WITH_NEW_PROJECT/PROJECT_NAME.csproj", "FOLDER_WITH_NEW_PROJECT/"]
example: COPY ["Documents/Documents.csproj", "Documents/"]
...

RUN dotnet restore "PP/Server/PP.Server.csproj"
```

There is one more way to make a dockerfile without editing itself. If you have one new project its not to much work, but if you add 10 projects or modules and want to add these to dockerfile, just click right mouse button on Server project -> Add -> Docker Support...
And then select linux or windows and that's it.
