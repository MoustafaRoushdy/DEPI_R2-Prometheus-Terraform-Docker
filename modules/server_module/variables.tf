variable "server_name" {
  
}

variable "script_path" {
  
}

variable "web_port" {
  default = ""
}

variable "file_name" {
  default = ""
}

variable "is_file_copied" {
  default = false
  description = "Flag to indicate if a file should be copied to the server"
}

variable "use_web_port" {
  default = false
}