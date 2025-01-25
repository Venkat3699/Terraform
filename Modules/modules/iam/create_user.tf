
# Step 1: Create the IAM User
resource "aws_iam_user" "admin_user" {
  name = var.username # Change to your desired username

  tags = {
    Name   = "${var.env}_admin_read-tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = var.env
  }
}

# Step 2: Create a Login Profile for Console Access
resource "aws_iam_user_login_profile" "admin_user_login" {
  user                    = aws_iam_user.admin_user.name
  password_reset_required = true # Require the user to reset the password on first login
}

resource "aws_iam_user_policy_attachment" "attach_policy_to_user" {
  user       = aws_iam_user.admin_user.name
  policy_arn = aws_iam_policy.admin_read_only.arn
}

#create access key ID and secret key 
resource "aws_iam_access_key" "admin_user_access_key" {
  user = aws_iam_user.admin_user.name
}

locals {
  admin_keys_csv = <<EOF
    username,password,access_key,secret_key
    ${aws_iam_user.admin_user.name},${aws_iam_user_login_profile.admin_user_login.password},${aws_iam_access_key.admin_user_access_key.id},${aws_iam_access_key.admin_user_access_key.secret}
    EOF
}

resource "local_file" "admin_keys" {
  content  = local.admin_keys_csv
  filename = "${var.username}-keys.csv"
}
