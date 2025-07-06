data "aws_subnet" "subnet_id" {
    filter {
        name   = "vpc-id"
        values = [var.vpc_id]
    }
}

resource "aws_db_subnet_group" "db_subnet_group" {
    subnet_ids = data.aws_subnet.subnet_id.id
}

resource "aws_db_instance" "my_database" {
    allocated_storage    = var.allocated_storage
    db_name              = var.db_username
    engine               = var.engine
    instance_class       = var.instance_class
    username             = var.db_username
    password             = var.db_passord
    port                 = var.db_port
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}