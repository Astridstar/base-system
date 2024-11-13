# Vault configuration file


# Raft storage backend
storage "raft" {
  path = "/vault/data"
}

# TCP listener
listener "tcp" {
  address     = "0.0.0.0:8200"
  #tls_cert_file = "/opt/vault/tls/vault-cert.pem"
  #tls_key_file  = "/opt/vault/tls/vault-key.pem"
  #tls_client_ca_file = "/opt/vault/tls/vault-ca.pem"
  tls_disable = "true" 
}

# Disable mlock to avoid out-of-memory errors
disable_mlock = true

ui = true

# Cluster address and API address
api_addr = "http://127.0.0.1:8200"
cluster_addr = "http://127.0.0.1:8201"
