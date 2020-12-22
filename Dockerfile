FROM mcr.microsoft.com/dotnet/sdk:5.0 as Builder

RUN mkdir --parents /app /app/src/Notebook
WORKDIR /app
COPY src/Notebook.sln ./src
COPY src/Notebook/Notebook.csproj ./src/Notebook

WORKDIR /app/src
RUN dotnet restore

COPY src .

WORKDIR /app/src/Notebook
RUN dotnet run

FROM nginx:stable-alpine

RUN rm /usr/share/nginx/html/*
COPY --from=Builder /app/src/Notebook/output /usr/share/nginx/html