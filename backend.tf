terraform {
    required_version = ">= 0.12.4"

    backend "s3" {
        bucket = "terraform-state-storing"
        key = "states/jenkins-ec2/jenkins.tfstate"
        profile = "wiciu-admin"
        region = "us-east-1"
    }
}