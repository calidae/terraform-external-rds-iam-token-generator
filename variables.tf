variable "db_instances" {
  type = map(object({
    hostname = string
    port = number
    username = string
  }))
}
