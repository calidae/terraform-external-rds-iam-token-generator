output "tokens" {
  description = "A map of iam authentication tokens for every given instances."
  value       = {
    for key, instance in data.external.this :
    key => instance.result.token
  }
  sensitive   = true
}
