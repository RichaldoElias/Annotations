# contains all my output variables

#output
# creating two output values to expert the id and ARN of the created instance

output "server_id" {
  value = aws_instance.web_server.id
  
}

output "server_arn" {
  value = aws_instance.web_server.arn
}