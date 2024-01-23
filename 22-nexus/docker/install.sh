sudo mkdir -p $HOME/storage/docker/nexus/data && sudo chown -R 200 $HOME/storage/docker/nexus/data
sudo docker run -d -p 8081:8081 --name nexus -v $HOME/storage/docker/nexus/data:/nexus-data sonatype/nexus3

