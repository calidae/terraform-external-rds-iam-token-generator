data "external" "this" {
  program = [
    "sh",
    "-e",
    "${path.module}/generate-token.sh",
    "--hostname",
    each.value.hostname,
    "--port",
    each.value.port,
    "--username",
    each.value.username,
  ]
  for_each = var.db_instances
}
