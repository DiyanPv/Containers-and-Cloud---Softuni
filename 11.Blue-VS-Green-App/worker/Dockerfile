# Stage 1: Build
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS builder

# Create a working directory
WORKDIR /Worker

# Copy the .csproj file and restore dependencies
COPY src/Worker/Worker.csproj .

RUN dotnet restore

# Copy the rest of the source files to the image
COPY src/Worker/ .

# Build the project
RUN dotnet publish Worker.csproj -c Release -o out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/core/runtime:3.1

# Specify working directory for this stage
WORKDIR /app

# Copy the /out directory from the build stage into the runtime image
COPY --from=builder /Worker/out .

# Tell Docker what command to run when the image is executed inside a container
ENTRYPOINT ["dotnet", "Worker.dll"]
