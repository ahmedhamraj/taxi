#############################
### Jenkins Master Outputs
#############################


output "master_id" {
    description = "ID of the MASTER EC2 instance"
    value       = aws_instance.master.id
}

output "master_public_ip" {
    description = "Public IP address of the MASTER EC2 instance"
    value       = aws_instance.master.public_ip
}


output "master_private_ip" {
    description = "Private IP address of the MASTER EC2 instance"
    value       = aws_instance.master.private_ip
}

#############################
### Jenkins Slave Outputs
#############################

output "slave_id" {
    description = "ID of the SLAVE EC2 instance"
    value       = aws_instance.slave.id
}

output "slave_public_ip" {
    description = "Public IP address of the SLAVE EC2 instance"
    value       = aws_instance.slave.public_ip
}

output "slave_private_ip" {
    description = "Private IP address of the SLAVE EC2 instance"
    value       = aws_instance.slave.private_ip
}


