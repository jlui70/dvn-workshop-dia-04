data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["workshop-devops-na-nuvem-vpc"]
  }
}
