FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
COPY . /src
WORKDIR /src
RUN dotnet build Bake.Release.slnf -c Release
ARG APP
RUN dotnet publish ./src/${APP} --no-build -c Release -o /app /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:9.0
ENV ASPNETCORE_URLS=http://+:80
COPY --from=build /app /app
WORKDIR /app
ARG APP
RUN ln -s ${APP}.dll Api.dll

EXPOSE 80
ENTRYPOINT ["dotnet", "Api.dll"]