locals {
  ami               = data.aws_ami.joindevops.id
  mongodb           = data.aws_ssm_parameter.mongo_sg.value
  database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_id.value)[0]
  redis             = data.aws_ssm_parameter.redis_sg.value
  mysql             = data.aws_ssm_parameter.mysql_sg.value
  rabbitmq          = data.aws_ssm_parameter.rabbitmq_sg.value
}