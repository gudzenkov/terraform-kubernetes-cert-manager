output "namespace" {
  value = var.create_namespace ? kubernetes_namespace.cert_manager[0].id : var.namespace_name
}
output "cluster_issuers" {
  description = "Map of Cluster Issuer configurations."
  value = var.cluster_issuers
}

output "certificates" {
  description = "Map of Certificates managed by the module."
  value = module.certificates
}
