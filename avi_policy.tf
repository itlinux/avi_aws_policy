terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}
provider "aws" {
  region = var.region
}

locals {
  avi_prefix = "remo"
}

resource "aws_iam_user" "new_user" {
  name = "remo-tf-demo-iam"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${local.avi_prefix}-bucket-tfdemo"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    owner = "Remo Mattei"
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  acl = "private"
}

data "http" "avi_data_vmimport" {
  url = var.git_raw_url_vmimport
  request_headers = {
    Accept = "application/json"
  }
}
data "http" "avi_data_kms" {
  url = var.git_raw_url_kms
  request_headers = {
    Accept = "application/json"
  }
}
data "http" "avi_data_avicontroller_role_trust" {
  url = var.git_raw_url_avicontroller_role_trust
  request_headers = {
    Accept = "application/json"
  }
}
data "http" "avi_data_avicontroller_iam" {
  url = var.git_raw_url_avicontroller_iam
  request_headers = {
    Accept = "application/json"
  }
}
data "http" "avi_data_avicontroller_ec2" {
  url = var.git_raw_url_avicontroller_ec2
  request_headers = {
    Accept = "application/json"
  }
}

data "http" "avi_data_avicontroller_S3" {
  url = var.git_raw_url_avicontroller_S3
  request_headers = {
    Accept = "application/json"
  }
}
data "http" "avi_data_avicontroller_r53" {
  url = var.git_raw_url_avicontroller_R53
  request_headers = {
    Accept = "application/json"
  }
}

data "http" "avi_data_avicontroller_asg" {
  url = var.git_raw_url_avicontroller_asg
  request_headers = {
    Accept = "application/json"
  }
}
data "http" "avi_data_avicontroller_sqs" {
  url = var.git_raw_url_avicontroller_sqs
  request_headers = {
    Accept = "application/json"
  }
}
resource "aws_iam_policy" "policy_vmimport" {
  name        = "${local.avi_prefix}-policy-vmimport"
  description = "vmimport-role-policy"
policy =  data.http.avi_data_vmimport.body
}
resource "aws_iam_policy" "policy_kms" {
  name        = "${local.avi_prefix}-policy-kms"
  description = "kms-policy"
policy =  data.http.avi_data_kms.body
}
resource "aws_iam_policy" "policy_avitrust" {
  name        = "${local.avi_prefix}-avi-controller-trust-role"
  description = "avicontroller-role-trust-policy"
policy =  data.http.avi_data_avicontroller_role_trust.body
}
resource "aws_iam_policy" "policy_avi_iam" {
  name        = "${local.avi_prefix}-avi-controller-iam"
  description = "avicontroller-iam-policy"
policy =  data.http.avi_data_avicontroller_iam.body
}
resource "aws_iam_policy" "policy_avictl_ec2" {
  name        = "${local.avi_prefix}-avicontroller-ec2-policy"
  description = "avicontroller-ec2-policy"
policy = data.http.avi_data_avicontroller_ec2.body
}

resource "aws_iam_policy" "policy_avi_s3" {
  name        = "${local.avi_prefix}-avicontroller-S3-policy"
  description = "Avicontroller-S3-policy.json"
policy = data.http.avi_data_avicontroller_S3.body
}
resource "aws_iam_policy" "policy_avi_r53" {
  name        = "${local.avi_prefix}-avicontroller-R53-policy"
  description = "Avicontroller-R53-policy.json"
policy = data.http.avi_data_avicontroller_r53.body  
}
resource "aws_iam_policy" "policy_avi_asg" {
  name        = "${local.avi_prefix}-avicontroller-asg-policy"
  description = "Avicontroller-asg-policy.json"
policy = data.http.avi_data_avicontroller_asg.body
}

resource "aws_iam_policy" "policy_avi_sqs" {
  name        = "${local.avi_prefix}-avicontroller-sqs-policy"
  description = "Avicontroller-sqs-policy.json"
policy = data.http.avi_data_avicontroller_sqs.body
}

data "aws_iam_policy_document" "assume_vmimport_role_trust" {
    statement {
    sid = "STSassumeRole"
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["${local.avi_prefix}-poligy-vmimport"]
    }
  }
}
data "aws_iam_policy_document" "ec2_amazonaws" {
    statement {
    sid = "STSassumeRole"
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["${local.avi_prefix}-avicontroller-role-trust"]
    }
  }
}

resource "aws_iam_policy_attachment" "avi-attach" {
  name       = "avi-attachment"
  users      = [aws_iam_user.new_user.name]
  /* roles      = [aws_iam_role.role.name] */
  /* groups     = [aws_iam_group.group.name] */
  policy_arn = aws_iam_policy.policy_avi_iam.arn
}