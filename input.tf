variable "secret_key" {
}

variable "access_key" {
}

variable "oktaasa_team" {
}

variable "oktaasa_key" {
}

variable "oktaasa_secret" {
}

provider "aws" {
  region     = "us-east-2"
  secret_key = var.secret_key
  access_key = var.access_key
}

provider "oktaasa" {
  oktaasa_team   = var.oktaasa_team
  oktaasa_key    = var.oktaasa_key
  oktaasa_secret = var.oktaasa_secret
}

variable "name" {
  type    = string
  default = "pied-pepper-burst"
}

variable "environment" {
  type    = string
  default = "pied-pepper"
}

variable "sftd_version" {
  type    = string
  default = "1.44.6"
}

variable "oktaasa_project" {
  description = "Name of the ASA Project"
  default     = "pied-pepper-burst-test"
}

variable "oktaasa_group" {
  description = "Name of the ASA Group"
  default     = "PP_DevOps"
}

