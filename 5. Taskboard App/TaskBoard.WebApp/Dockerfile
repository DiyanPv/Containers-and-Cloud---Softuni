# Base image for the runtime environment
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copy the .csproj files and restore dependencies
COPY ["./TaskBoard.WebApp/TaskBoard.WebApp.csproj", "TaskBoard.WebApp/"]
COPY ["./TaskBoard.Data/TaskBoard.Data.csproj", "TaskBoard.Data/"]
RUN dotnet restore "TaskBoard.WebApp/TaskBoard.WebApp.csproj"

# Copy the remaining source code and build the project
COPY . .
WORKDIR "/src/TaskBoard.WebApp"
RUN dotnet build "TaskBoard.WebApp.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Publish stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "TaskBoard.WebApp.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Final stage: runtime environment
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TaskBoard.WebApp.dll"]
