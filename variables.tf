variable "namespace_name" {
  default = "cert-manager"
}

variable "create_namespace" {
  type        = bool
  description = "(Optional) Create namespace?"
  default     = true
}

variable "chart_version" {
  type        = string
  description = "HELM Chart Version for cert-manager"
  default     = "1.11.0"
}

variable "install_crds" {
  description = "Whether to install CRDs"
  type        = bool
  default     = true
}

variable "cluster_issuers" {
  description = <<EOF
  Map of Cluster Issuer configurations. Each key is a Cluster Issuer name with its configuration:
    - email: Email address used for ACME registration
    - private_key_secret_name: Name of a secret used to store the ACME account private key
    - server: The ACME server URL
    - preferred_chain: Preferred chain for ClusterIssuer
    - yaml: (Optional) Custom YAML configuration for the ClusterIssuer
  EOF
  type = map(object({
    email                  = optional(string, "admin@mysite.com")
    private_key_secret_name = optional(string, "cert-manager-private-key")
    server                 = optional(string, "https://acme-staging-v02.api.letsencrypt.org/directory")
    preferred_chain        = optional(string, "ISRG Root X1")
    yaml                   = optional(string, null)
  }))
}

variable "cluster_issuer_create" {
  description = "Create Cluster Issuer"
  type        = bool
  default     = true
}

variable "additional_set" {
  type        = list(any)
  description = "Additional sets to Helm"
  default     = []
}

variable "solvers" {
  description = "List of Cert manager solvers. For a complex example please look at the Readme"
  type        = any
  default = [{
    http01 = {
      ingress = {
        class = "nginx"
      }
    }
  }]
}

variable "certificates" {
  description = "List of Certificates"
  type        = any
  default     = {}
}
