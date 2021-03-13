variable "environment" {
  type        = string
  description = "The environment provisioned."
}

variable "region" {
  type        = string
  description = "The region where the resource will be provisioned."
}

variable "hostname" {
  type        = string
  description = "The instance hostname to be provisioned."
}
