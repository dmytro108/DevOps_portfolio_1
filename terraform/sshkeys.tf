resource "aws_key_pair" "webserver" {
  key_name   = "webserver-key"
  public_key = var.webserver_pub_key

  tags = {
    "Name" = "${var.name_pref}key"
  }
}