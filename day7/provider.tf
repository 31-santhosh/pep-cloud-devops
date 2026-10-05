provider "aws"{
    region = "us-east-1"
}
resource "aws_iam_user" "terrademo1" {
  name = "sandemo-T1"
  path = "/"

  tags = {
    purpose = "hand-on"
  }
}