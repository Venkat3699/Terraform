variable "rolename" {}
variable "policyname" {}
variable "env" {}
variable "instanceprofilename" {}
variable "username" {}
variable "password" {
  description = "The password for the IAM user"
  sensitive   = true # Mark as sensitive to avoid logging
}
