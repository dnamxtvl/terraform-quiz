# firebase credentials
variable "firebase_api_key" {
  description = "Firebase API key"
  type        = string
}

variable "firebase_app_id" {
  description = "Firebase app ID"
  type        = string
}

variable "firebase_auth_domain" {
  description = "Firebase auth domain"
  type        = string
}

variable "firebase_measurement_id" {
  description = "Firebase measurement ID"
  type        = string
}

variable "firebase_messaging_sender_id" {
  description = "Firebase messaging sender ID"
  type        = string
}

variable "firebase_project_id" {
  description = "Firebase project ID"
  type        = string
}

variable "firebase_storage_bucket" {
  description = "Firebase storage bucket"
  type        = string
}

variable "firebase_vapid_key" {
  description = "Firebase VAPID key"
  type        = string
}

#google client id and client secret
variable "google_client_id" {
  description = "Google client ID"
  type        = string
}

#app url
variable "app_url" {
  description = "App URL"
  type        = string
}

#reverb key
variable "reverb_key" {
  description = "Reverb key"
  type        = string
}

#backend url
variable "backend_url" {
  description = "Backend URL"
  type        = string
}

#backend host
variable "backend_host" {
  description = "Backend host"
  type        = string
}

# Amplify IAM role ARN
variable "amplify_iam_role_arn" {
  description = "IAM role ARN for Amplify service"
  type        = string
}

# Domain name
variable "domain_name" {
  description = "Domain name for Amplify app"
  type        = string
}

# Repository URL
variable "repository_url" {
  description = "Repository URL"
  type        = string
}


# Front end domain name
variable "fe_domain" {
  description = "Front end domain name"
  type        = string
}