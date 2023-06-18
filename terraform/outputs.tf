output "public_ip" {
  description = "Control node publick IP address"
  value       = aws_eip.webserver_ip.public_ip
}

output "user" {
  value = aws_iam_user_login_profile.oversecured.user
}
output "password" {
  value = aws_iam_user_login_profile.oversecured.password
}