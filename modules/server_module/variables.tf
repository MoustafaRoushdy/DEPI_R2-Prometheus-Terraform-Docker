variable "server_name" {
  
}

variable "script_path" {
  
}

variable "web_port" {
  
}

variable "is_file_copied" {
  description = "Flag to check if the file is copied"
  type        = bool
  default     = false  
}

variable "file_name" {
  description = "Name of the file to be copied"
  type        = string 
  default     = ""
  nullable    = true
}