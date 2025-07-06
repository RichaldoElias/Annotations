# terraform main contains all resources configurations
# if  you have a lot of resources, you can split them into multiple files



/*  
    Data Sources
    Data blocks to reference resources created outside Terraform or by other Terraform workspace/configurations.
    --
    We can uyse data blocks to reference existing resources, such as AMIs, VPCs, or security groups.
*/

# let create the resource in a subnet already created

data "aws_subnet" "existing_subnet" {
    # replace with the ID of your existing subnet
    id = "subnet-0bb1c79de3EXAMPLE"
}

#ask terraform to get the latest Amazon Linux 2 AMI on my behalf
data "aws_ami" "latest_amazon_linux" {
    most_recent = true
    owners      = ["amazon"] # Amazon's official AMIs
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }

    filter {
        name   = "name"
        values = ["al202*-ami-202*"]
    }
}
# Resources
resource "aws_instance" "web_server" {
    ami           = data.aws_ami.latest_amazon_linux.id # Use the latest Amazon Linux 2 AMI
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.existing_subnet.id # Use the existing subnet
    tags = {
        Name = var.server_name
    }
}

