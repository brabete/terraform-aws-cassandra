resource "aws_instance" "cassandra-node0" {
  count             = "3"
  availability_zone = "${var.region}a"
  key_name          = "${aws_key_pair.cassandra.key_name}"
  ami               = "${data.aws_ami.ubuntu.image_id}"
  instance_type     = "${var.instance_type}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = 1
  }

  tags = {
    "Environment" = "Development"
  }

  security_groups = ["${aws_security_group.cassandra.name}"]
}

resource "aws_instance" "remote-cassandra-node3" {
  provider      = "aws.useast"
  key_name      = "${aws_key_pair.cassandrauseast.key_name}"
  ami           = "${data.aws_ami.ubuntu-useast.image_id}"
  instance_type = "${var.instance_type}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = 1
  }

  tags = {
    "Environment" = "Development"
  }

  security_groups = ["${aws_security_group.cassandrauseast.name}"]
}
