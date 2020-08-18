// Ubuntu 16.04 AMI
data "aws_ami" "ubuntu1604" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

// Security Group
module "security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "ssh"
  description = "Security group for SSH access"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

// Bastion Host
resource "aws_instance" "bastion" {
  count                  = 1
  ami                    = data.aws_ami.ubuntu1604.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${module.security_group.this_security_group_id}"]
  subnet_id              = var.public_subnet
  source_dest_check      = false
  user_data              = templatefile("${path.module}/userdata-scripts/ubuntu-bastion-userdata-sftd.sh", { sftd_version = var.sftd_version, enrollment_token = var.enrollment_token })

  tags = {
    Name        = "${var.tagname}"
    Environment = var.environment
    terraform   = true
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}

// Target Instances
resource "aws_instance" "target" {
  count                  = var.instances
  ami                    = data.aws_ami.ubuntu1604.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${module.security_group.this_security_group_id}"]
  subnet_id              = var.private_subnet
  source_dest_check      = false
  user_data              = templatefile("${path.module}/userdata-scripts/ubuntu-userdata-sftd.sh", { sftd_version = var.sftd_version, enrollment_token = var.enrollment_token, instance = count.index})

  tags = {
    Name        = "${var.tagname}-${count.index}"
    Environment = var.environment
    terraform   = true
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}