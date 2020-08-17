variable "tagname" {
  type    = string
  default = "linux"
}

variable name {
  type = string
}

variable environment {
  type = string
}

variable vpc_id {
  type = string
}

variable instances {
  type = number
}

variable subnet {
  type = list(any)
}

variable sftd_version {
  type = string
}

variable enrollment_token {
  type = string
}
