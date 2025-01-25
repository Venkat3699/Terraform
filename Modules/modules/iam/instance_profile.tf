resource "aws_iam_instance_profile" "admin_read_only_profile" {
  name = var.instanceprofilename
  role = aws_iam_role.admin_read_only_role.name
}