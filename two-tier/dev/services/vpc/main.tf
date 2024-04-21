terraform {
    backend "s3" {
        bucket = "proj2-vpc2tier-tfstate"
        key = "dev/services/vpc/terraform.tfstate"
        region = "eu-central-1"
        dynamodb_table = "proj2-vpc2tier-locks"
        encrypt = true
    }
}


