variable "server_name" {
  
}

variable "script_path" {
  
}

variable "web_port" {
  default = 80
}

variable "file_name" {
  default = ""
}

variable "is_file_copied" {
  default = false
  description = "Flag to indicate if a file should be copied to the server"
}

variable "enable_web_ingress" {
  default = true
  description = "Flag to enable web ingress rules"
}