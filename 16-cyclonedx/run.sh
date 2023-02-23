sudo docker run -d --name cyclonedx \
    -v $HOME/projects/system/generator/:/app/generator \
    -v $HOME/projects/sbom:/app/generator/sbom \
    cyclonedx/cyclonedx-dotnet:latest \
    /app/generator/data-gen.csproj -o /app/generator/sbom \
    