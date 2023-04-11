#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["PP/Server/PP.Server.csproj", "PP/Server/"]
COPY ["PP/Client/PP.Client.csproj", "PP/Client/"]
COPY ["SystemZamowien/SystemZamowien.csproj", "SystemZamowien/"]
COPY ["Usterki/Usterki.csproj", "Usterki/"]
COPY ["PP/Shared/PP.Shared.csproj", "PP/Shared/"]
RUN dotnet restore "PP/Server/PP.Server.csproj"
COPY . .
WORKDIR "/src/PP/Server"
RUN dotnet build "PP.Server.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PP.Server.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "PP.Server.dll"]