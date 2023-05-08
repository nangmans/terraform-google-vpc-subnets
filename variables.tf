variable "config_directories" {
  description = "List of paths to folders where routes configs are stored in yaml format. Folder may include subfolders with configuration files. Files suffix must be `.yaml`."
  type        = list(string)
}

variable "project_id" {
  description = "The project ID to deploy to"
}

variable "network_name" {
  description = "The name of the network to deploy to"
}

variable "impersonate_sa" {
  description = "Email of the service account to use for Terraform"
  type        = string
}

variable "validate_labels" {
  description = "validate labels"
  type        = map(string)
}
