output "role_name" {
  value = aws_iam_role.admin_read_only_role.name
}

output "role_arn" {
  value = aws_iam_role.admin_read_only_role.arn
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.admin_read_only_profile.name
}


output "user_name" {
  value = aws_iam_user.admin_user.name
}

output "password" {
  value     = aws_iam_user_login_profile.admin_user_login.password
  sensitive = true
}

output "access_key_id" {
  value     = aws_iam_access_key.admin_user_access_key.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.admin_user_access_key.secret
  sensitive = true
}