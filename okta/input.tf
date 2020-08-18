variable "project" {
  type        = string
  description = "Name of the ASA Project"
}

variable "group" {
  type        = string
  description = "Name of the ASA Group"
}

variable "groups" {
  type        = list(string)
  description = "Name of the ASA Groups"
}