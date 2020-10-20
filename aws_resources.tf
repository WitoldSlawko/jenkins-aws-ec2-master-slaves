resource "aws_instance" "jenkins_master" {
    ami = "ami-0947d2ba12ee1ff75"
    count = 1
    instance_type = "t2.small"
    key_name = "jenkins-ec2-key"
    associate_public_ip_address = true
    vpc_security_group_ids  = ["sg-a1d8e08a"] 
    user_data = templatefile("${path.cwd}/template_scripts/master.tmpl", {})
    
    connection {
        host = self.public_ip
        type = "ssh"
        user = "ec2-user"
        private_key = file("~/Downloads/jenkins-ec2-key.pem")
        region = "us-east-1"
    }

    tags = {
        Name = "Jenkins-Master"
        ProvisionedBy = "Terraform"
    }
}

resource "aws_instance" "jenkins_slave" {
    ami  = "ami-0947d2ba12ee1ff75"
    count = 2
    instance_type = "t2.micro"
    key_name = "jenkins-ec2-key"
    associate_public_ip_address = true
    vpc_security_group_ids = ["sg-a1d8e08a"]
    user_data = templatefile("${path.cwd}/template_scripts/slave.tmpl", {})

    tags = {
        Name = "Jenkins-Slave-${count.index+1}"
        ProvisionedBy = "Terraform"
    }
}