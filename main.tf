# MONGODB
resource "aws_instance" "mongodb" {
  ami                    = local.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.mongodb]
  subnet_id              = local.database_subnet_id
  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-mongodb"
  })
}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  connection {
    type     = "ssh"      # SSH or WinRM
    user     = "ec2-user" # Remote username
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip # Remote address
  }

  provisioner "file" {
    source      = "bootstrap.sh"      # Local file/directory to copy
    destination = "/tmp/bootstrap.sh" # Remote path to place file/content
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
    ]
  }
}

resource "aws_route53_record" "mongodb" {
  zone_id         = var.zone_id
  name            = "mongodb-${var.environment}.${var.zone_name}"
  type            = "A"
  ttl             = 300
  records         = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}

# REDIS
resource "aws_instance" "redis" {
  ami                    = local.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.redis]
  subnet_id              = local.database_subnet_id
  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-redis"
  })
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  connection {
    type     = "ssh"      # SSH or WinRM
    user     = "ec2-user" # Remote username
    password = "DevOps321"
    host     = aws_instance.redis.private_ip # Remote address
  }

  provisioner "file" {
    source      = "bootstrap.sh"      # Local file/directory to copy
    destination = "/tmp/bootstrap.sh" # Remote path to place file/content
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
    ]
  }
}

resource "aws_route53_record" "redis" {
  zone_id         = var.zone_id
  name            = "redis-${var.environment}.${var.zone_name}"
  type            = "A"
  ttl             = 300
  records         = [aws_instance.redis.private_ip]
  allow_overwrite = true
}

# mysql
resource "aws_instance" "mysql" {
  ami                    = local.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.mysql]
  subnet_id              = local.database_subnet_id
  iam_instance_profile   = "EC2FETCHSSMPARAM"
  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-mysql"
  })
}

resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]

  connection {
    type     = "ssh"      # SSH or WinRM
    user     = "ec2-user" # Remote username
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip # Remote address
  }

  provisioner "file" {
    source      = "bootstrap.sh"      # Local file/directory to copy
    destination = "/tmp/bootstrap.sh" # Remote path to place file/content
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
    ]
  }
}

resource "aws_route53_record" "mysql" {
  zone_id         = var.zone_id
  name            = "mysql-${var.environment}.${var.zone_name}"
  type            = "A"
  ttl             = 300
  records         = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}

# rabbitmq
resource "aws_instance" "rabbitmq" {
  ami                    = local.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.rabbitmq]
  subnet_id              = local.database_subnet_id
  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-rabbitmq"
  })
}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  connection {
    type     = "ssh"      # SSH or WinRM
    user     = "ec2-user" # Remote username
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip # Remote address
  }

  provisioner "file" {
    source      = "bootstrap.sh"      # Local file/directory to copy
    destination = "/tmp/bootstrap.sh" # Remote path to place file/content
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
    ]
  }
}

resource "aws_route53_record" "rabbitmq" {
  zone_id         = var.zone_id
  name            = "rabbitmq-${var.environment}.${var.zone_name}"
  type            = "A"
  ttl             = 300
  records         = [aws_instance.rabbitmq.private_ip]
  allow_overwrite = true
}