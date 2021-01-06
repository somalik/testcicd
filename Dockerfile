#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
ENV TZ=Asia/Karachi
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["TestCICDAPI.csproj", "testcicd/"]
RUN dotnet restore "testcicd/TestCICDAPI.csproj"
COPY . .
WORKDIR "/src/testcicd"
RUN dotnet build "TestCICDAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TestCICDAPI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "TestCICDAPI.dll"]