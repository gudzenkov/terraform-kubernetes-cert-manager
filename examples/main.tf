module "cert_manager" {
  source = "../"

  cluster_issuers = {
    "cert-manager-staging" = {
      email                   = "admin@mysite.com"
      private_key_secret_name = "cert-manager-stage-private-key"
      server                  = "https://acme-staging-v02.api.letsencrypt.org/directory"
    },
    "cert-manager-production" = {
      // Example of supplying a custom YAML configuration for a ClusterIssuer
      yaml                    = <<-EOT
        apiVersion: cert-manager.io/v1
        kind: ClusterIssuer
        metadata:
          name: cert-manager-prod
        spec:
          acme:
            server: https://acme-v02.api.letsencrypt.org/directory
            email: admin@prod.mysite.com
            privateKeySecretRef:
              name: cert-manager-prod-private-key
            solvers:
            - http01:
                ingress:
                  class: nginx
        EOT
    }
  }
}
