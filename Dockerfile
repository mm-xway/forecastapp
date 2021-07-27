# Stage 1
FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /build 
#EXPOSE 10080
COPY . .
RUN dotnet restore 
RUN dotnet publish -c Release -o /app 

# Stage 2 
FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine3.12 AS final 
WORKDIR /app
EXPOSE 10080
COPY --from=build /app .
ENTRYPOINT ["dotnet", "forecast.dll"]