variable "region" {
  default = "us-west-1"
}
variable "prefix" {
  default = "remo"
}
variable "bucket_name" {
  default = "my_avi_bucket"  
}
variable "department" {
  default = "Avi SA Team"  
}
variable "owner" {
  default = "Remo Mattei"
}
variable "new_user" {
  default = "myavi_iam_user"
}
variable "git_raw_url_vmimport" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/vmimport-role-policy.json"
}
variable "git_raw_url_kms" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/avicontroller-kms-vmimport.json"
}
variable "git_raw_url_avicontroller_role_trust" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/avicontroller-ec2-policy.json"
}
variable "git_raw_url_avicontroller_ec2" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/avicontroller-ec2-policy.json"
}
variable "git_raw_url_avicontroller_S3" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/avicontroller-s3-policy.json"
}
variable "git_raw_url_avicontroller_R53" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/avicontroller-r53-policy.json"
}
variable "git_raw_url_avicontroller_asg" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/avicontroller-asg-policy.json"  
}
variable "git_raw_url_avicontroller_sqs" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/avicontroller-sqs-sns-policy.json"
}

variable "git_raw_url_avicontroller_iam" {
  default = "https://raw.githubusercontent.com/avinetworks/devops/master/aws/iam-policies/avicontroller-iam-policy.json"
  
}