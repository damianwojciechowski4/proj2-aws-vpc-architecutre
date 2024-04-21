bucket = var.backend_bucket
key = "dev/services/ec2/terraform.tfstate"
region = "eu-central-1"
dynamodb_table = var.backend_dynamodb_table
encrypt = true