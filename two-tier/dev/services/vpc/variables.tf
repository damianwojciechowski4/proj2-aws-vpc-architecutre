variable "backend_bucket" {
    type = string
    description = "S3 bucket for terraform state"
}

variable "backend_dynamodb_table" {
    type = string
    description = "DynamoDB table for terraform state locking"
}


