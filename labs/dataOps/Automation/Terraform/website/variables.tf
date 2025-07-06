# contains all my input variables

# input
variable "region" {
    description = "region for aws resources"
    type        = string
    # if not assigned, then you'll be prompter to specify its value before terraform applies the configuration
    default     = "us-east-1" 
}

variable "server_name" {
    description = "name of the server running the website"
    type        = string
}