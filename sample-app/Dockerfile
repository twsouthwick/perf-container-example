FROM microsoft/aspnetcore:2.0.5-jessie AS base
WORKDIR /app

FROM microsoft/dotnet:2.0-sdk-jessie AS builder
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app
RUN dotnet publish -c Release --self-contained -r linux-x64 -o /app-selfcontained

FROM base as production

COPY --from=builder /app .
COPY --from=builder /root/.nuget/packages/runtime.linux-x64.microsoft.netcore.app/2.0.0/tools/crossgen /usr/share/dotnet/shared/Microsoft.NETCore.App/2.0.5/

# Install curl so that we can download dependencies.
RUN apt-get -y update && apt-get install -y curl sudo kmod binutils

# Download the latest perfcollect.
RUN mkdir /perf && cd /perf && curl -OL https://aka.ms/perfcollect && chmod +x perfcollect

# Set tracing environment variables.
ENV COMPlus_PerfMapEnabled 1
ENV COMPlus_EnableEventLog 1
