resource "aws_instance" "master" {
  ami                         = var.ami_id
  instance_type               = var.master_instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true

  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
      instance_type
    ]
  }

  tags = {
    Name = "master"
  }
}

resource "aws_instance" "slave" {
    ami                         = var.ami_id
    instance_type               = var.slave_instance_type
    key_name                    = var.key_name
    associate_public_ip_address = false   # USING ELASTIC IP

    root_block_device {
        delete_on_termination = false     # KEEP SLAVE DATA SAFE
    }

    lifecycle {
        ignore_changes = [
            instance_type,                # PREVENT TERRAFORM FROM DELETING INSTANCE
            associate_public_ip_address
        ]
    }

    tags = {
        Name = "slave"
    }
}

resource "aws_eip" "slave_eip" {
    instance = aws_instance.slave.id

    tags = {
        Name = "slave-eip"
    }
}


data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "eks_subnets" {
    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
    
    filter {
        name = "availability-zone"
        values = ["us-east-1a", "us-east-1b", "us-east-1f"]
    }
}

module "sgs" {
    source = "./sg_eks"
    vpc_id = data.aws_vpc.default.id
}

module "eks" {
    source         = "./eks"
    subnet_ids      = data.aws_subnets.eks_subnets.ids
    vpc_id          = data.aws_vpc.default.id
    sg_ids          = module.sgs.security_group_ids
}


