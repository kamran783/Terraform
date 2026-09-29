ec2_config = [{
  ami           = "ami-0ef742f2f600ff2fb"
  instance_type = "t3.micro"
  }, {
  ami           = "ami-0199ac7c9fbf9ed83"
  instance_type = "t3.micro"
}]


ec2_map = {
  "ubuntu" = {
    ami           = "ami-0ef742f2f600ff2fb"
    instance_type = "t3.micro"
    }, "linux" = {
    ami           = "ami-0199ac7c9fbf9ed83"
    instance_type = "t3.micro"
  }
}
