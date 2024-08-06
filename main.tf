provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "testing" {
  backend = "remote"
  config = {
    organization = "knjoroge-org"
    workspaces = {
      name = "aws-2-test-environment"
    }
  }
}

resource "aws_instance" "prod" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.testing.outputs.subnet_id
}
