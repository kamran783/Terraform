variable "aws_instance_type" {
  description = "Type of instance to be created?"
  type        = string
  validation {
    condition     = var.aws_instance_type == "t3.micro" || var.aws_instance_type == "t3.small"
    error_message = "only t3.micro and t3.small are allowed"
  }
}

variable "root_volume_type" {
  type    = string
  default = "gp2"
}

variable "root_volume_size" {
  type    = number
  default = 20
}
