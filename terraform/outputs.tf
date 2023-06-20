output "public_ip" {
  description = "Web server publick IP address"
  value       = aws_eip.webserver_ip.public_ip
}
output "public_address" {
  description = "Web server DNS"
  value       = aws_eip.webserver_ip.public_dns
}
output "user" {
  value = aws_iam_user_login_profile.oversecured.user
}
output "password" {
  value = aws_iam_user_login_profile.oversecured.password
}