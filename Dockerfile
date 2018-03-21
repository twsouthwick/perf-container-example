####################################################
# Docker image for performance testing of .NET Core.
####################################################
FROM tasou/perf

# Install curl so that we can download dependencies.
RUN apt-get -y update && apt-get install -y curl

# Download the latest perfcollect.
RUN mkdir /perf && cd /perf && curl -OL https://aka.ms/perfcollect && chmod +x perfcollect
