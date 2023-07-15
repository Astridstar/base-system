To start using the scripts:

1. install multipass
2. generate the public/private ssh keys
3. paste the public keys to the cloud-init.yaml
4. Update create-vm scripts to point to the right ssh keys

** At ~/.ssh/config, add the following to the file
(for MAC host)

Host <hostname>.local
  AddKeysToAgent yes
  IgnoreUnknown UseKeychain
  IdentityFile <Identity-file>
  ControlMaster	auto
  ControlPath	~/.ssh/control-%C
  ControlPersist yes


** once docker has been setup successfully, go back to the host machine to set the docker context
$> docker context create \
  --docker host=ssh://ubuntu@dev-svr-1.local \
  --description="multipass docker engine" \
  mp-docker-engine

$>docker context use mp-docker-engine
$>docker info