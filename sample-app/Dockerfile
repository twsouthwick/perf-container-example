FROM microsoft/aspnetcore:2.0.5-jessie AS base
WORKDIR /app

FROM microsoft/dotnet:2.0-sdk-jessie AS builder
WORKDIR /src
COPY . .
RUN dotnet publish -o /app
RUN dotnet publish --self-contained -r linux-x64 -o /app-selfcontained
RUN dotnet nuget locals all -l

FROM base as production

COPY --from=builder /app .
COPY --from=builder /root/.nuget/packages/runtime.linux-x64.microsoft.netcore.app/2.0.0/tools/crossgen /usr/share/dotnet/shared/Microsoft.NETCore.App/2.0.5/
 
WORKDIR /app-self
COPY --from=builder /app-selfcontained .

# Install curl so that we can download dependencies.
RUN apt-get -y update && apt-get install -y curl vim

# Download the latest perfcollect.
RUN mkdir /perf && cd /perf && curl -OL https://aka.ms/perfcollect && chmod +x perfcollect

COPY bootstrap /perf/bootstrap
RUN chmod +x /perf/bootstrap

# Set tracing environment variables.
ENV COMPlus_PerfMapEnabled 1
ENV COMPlus_EnableEventLog 1
