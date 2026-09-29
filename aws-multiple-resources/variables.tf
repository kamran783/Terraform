variable "ec2_config" {
  type = list(object({
    ami           = string
    instance_type = string
  }))
}


variable "ec2_map" {
    type = map(object({
        ami           = string
        instance_type = string
    }))
}
