provider "aws" {
  region = "ap-southeast-1"
}

#create VPC

resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_vpc}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Prod-VPC"
  }
}

# create subnets

resource "aws_subnet" "subnet_priv1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet_priv1}"
  availability_zone = "${var.az_1}"

   tags = {
    Name = "Prod-subnet-priv-1"
  }
}

resource "aws_subnet" "subnet_priv2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet_priv2}"
  availability_zone = "${var.az_2}"

   tags = {
    Name = "Prod-subnet-priv-2"
  }
}

resource "aws_subnet" "subnet_pub1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet_pub1}"
  availability_zone = "${var.az_1}"

   tags = {
    Name = "Prod-subnet-pub-1"
  }
}

resource "aws_subnet" "subnet_pub2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet_pub2}"
  availability_zone = "${var.az_2}"

   tags = {
    Name = "Prod-subnet-pub-2"
  }
}

#create internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "DR-igw"
  }
}


#create elastic ip and nic

resource "aws_network_interface" "e_ip" {
  subnet_id   = "${aws_subnet.subnet_priv1.id}"
  private_ips = ["172.40.1.10"]
}

resource "aws_eip" "nat_eip" {
  vpc                       = true
  network_interface         = "${aws_network_interface.e_ip.id}"
  associate_with_private_ip = "172.40.1.10"

  tags = {
    Name = "DR-eip"
  }
}

#create natgateway

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.subnet_priv1.id}"
  depends_on = ["aws_internet_gateway.igw"]
  tags = {
    Name = "NAT gw"
  }
}

#create route table
resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.ngw.id}"
  }

  tags = {
    Name = "prod-routetable"
  }
}

#subnet assosiation for rout table

resource "aws_route_table_association" "rta_subnet_priv1" {
  subnet_id      = "${aws_subnet.subnet_priv1.id}"
  route_table_id = "${aws_route_table.route.id}"
}


resource "aws_route_table_association" "rta_subnet_priv2" {
  subnet_id      = "${aws_subnet.subnet_priv2.id}"
  route_table_id = "${aws_route_table.route.id}"
}

#copy ami image

resource "aws_ami_copy" "copy" {
  name              = "widget"
  source_ami_id     = "${var.ami_id}"
  source_ami_region = "${var.regi}"

  tags = {
    Name = "widget-dev-3"
  }
}
data "aws_ami" "copy1" {
  filter {
    name   = "state"
    values = ["available"]
  }
  most_recent = true
  owners      = ["self"]
}

#create security group

resource "aws_security_group" "widget_sg" {
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["35.154.236.243/32","10.40.30.106/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "widget-sg"
  }
}

#create ssh key

resource "aws_key_pair" "key" {
  key_name   = "abfl-test"
  public_key = "${var.key}"
}

#create new server

resource "aws_instance" "Instance" {
  ami           = "${data.aws_ami.copy1.id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${aws_subnet.subnet_priv1.id}"
  vpc_security_group_ids = ["${aws_security_group.widget_sg.id}"]
  key_name = "${aws_key_pair.key.key_name}"
}
