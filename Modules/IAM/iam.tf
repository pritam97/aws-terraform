resource "aws_iam_group" "admingroup" {
  name = "terraformadministrator"
}

# Creating  A User 

resource "aws_iam_user" "terraformuser1" {
  name = var.user
}
# Assigning Membership to user
resource "aws_iam_group_membership" "administrator-users" {
  name  = "administrator-users1"
  users = ["${aws_iam_user.terraformuser1.name}"]
  group = "${aws_iam_group.admingroup.name}"
}

resource "aws_iam_policy_attachment" "administrators-attach" {
  name       = "administrators-attach"
  groups     = ["${aws_iam_group.admingroup.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
output "warning" {
  value = "WARNING: make sure you're not using the AdministratorAccess policy for other users/groups/roles. If this is the case, don't run terraform destroy, but manually unlink the created resources"
}