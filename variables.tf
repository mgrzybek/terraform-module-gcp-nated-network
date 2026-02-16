variable "cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "network_mtu" {
  description = "The network MTU. Must be a value between 1300 and 8896."
  type        = number
  default     = 1460

  validation {
    condition     = var.network_mtu >= 1300 && var.network_mtu <= 8896
    error_message = "MTU's value must at least 1300 and at most 8896."
  }
}
