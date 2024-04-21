resource "aws_security_group"



   name = "my-launch-template"
    description = "My launch template"
    image_id = "ami-04dfd853d88e818e8"
    instance_type = "t2.micro"
    key_name = aws_key_pair.test_key.key_name
    vpc_security_group_ids = [aws_security_group.instance.id]
    
    user_data = base64encode(templatefile ("./user-data.tfpl",{
        server_port = var.server_port
        db_address = data.terraform_remote_state.db.outputs.address
        db_port = data.terraform_remote_state.db.outputs.port  
    }))
}