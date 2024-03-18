locals {
  cluster_issuers_config = { for name, ci in var.cluster_issuers : name => {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = name
    }
    spec = {
      acme = {
        # The ACME server URL
        server         = ci.server
        preferredChain = ci.preferred_chain
        # Email address used for ACME registration
        email          = ci.email
        # Name of a secret used to store the ACME account private key
        privateKeySecretRef = {
          name = ci.private_key_secret_name
        }
        # Enable the HTTP-01 challenge provider
        solvers = var.solvers
      }
    }
  }}
}
