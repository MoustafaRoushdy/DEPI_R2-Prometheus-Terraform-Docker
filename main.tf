module "jenkins_server" {
  source                = "./modules/server_module"
  server_name           = "jenkins"
  script_path           = "install_jenkins.sh"
  web_port              = 8080
  instance_profile_name = aws_iam_instance_profile.jenkins_profile.name
}


# module "prometheus_server" {
#   source = "./modules/server_module"
#   server_name = "prometheus"
#   script_path = "install_docker_prometheus.sh"
#   web_port = 9090
#   is_file_copied = true
#   file_name = "prometheus.yml"
# }
resource "aws_iam_policy" "ec2_full_access" {
  name        = "ec2_full_access"
  path        = "/"
  description = "ec2 full access for jenkins master"


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeSpotInstanceRequests",
          "ec2:CancelSpotInstanceRequests",
          "ec2:GetConsoleOutput",
          "ec2:RequestSpotInstances",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeRegions",
          "ec2:DescribeImages",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "iam:ListInstanceProfilesForRole",
          "iam:PassRole",
          "ec2:GetPasswordData"
        ]
        Effect   = "Allow"
        Resource = "*"

      },
    ]
  })
}

resource "aws_iam_role" "jenkins_master" {
  name = "jenkins_master"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "jenkins-attachment" {
  role       = aws_iam_role.jenkins_master.name
  policy_arn = aws_iam_policy.ec2_full_access.arn
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = aws_iam_role.jenkins_master.name
}