resource "aws_key_pair" "my-infra-key" {
    key_name = "${var.env}-infra-key"
    public_key = file("infra-key.pub")
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_sg" {
    name = "${var.env}_infra_sg"
    description = "Allow inbound traffic on port 22, port 80 and port 443"
    vpc_id = aws_default_vpc.default.id # interpolation

    ingress {
        description = "allow access to ssh and port 22"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "allow access to http and port 80"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "allow access to https and port 443"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "allow all traffic out"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.env}-infra-sg"
      Environment = var.env
    }
}

resource "aws_instance" "new_instance" {
    count = var.instances_count
    instance_type = var.instances_type
    ami = var.ami_id
    key_name = aws_key_pair.my-infra-key.key_name
    security_groups = [aws_security_group.my_sg.name]

    root_block_device {
        volume_size = var.volume_size
        volume_type = "gp3"
    }

    tags = {
      Name = "${var.env}-instance"
      Environment = var.env
    }

}
