FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["Treda.csproj", "./"]
RUN dotnet restore "Treda.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "Treda.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Treda.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Treda.dll"]
