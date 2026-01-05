output "amplify_app_id" {
  value       = aws_amplify_app.quizz_app.id
  description = "Amplify App ID"
}

output "amplify_app_arn" {
  value       = aws_amplify_app.quizz_app.arn
  description = "Amplify App ARN"
}

output "amplify_app_default_domain" {
  value       = aws_amplify_app.quizz_app.default_domain
  description = "Amplify App default domain"
}

output "amplify_branch_arn" {
  value       = aws_amplify_branch.master.arn
  description = "Amplify Branch ARN"
}

output "amplify_domain_association_arn" {
  value       = aws_amplify_domain_association.main.arn
  description = "Amplify Domain Association ARN"
}

output "amplify_subdomain_dns_records" {
  value = {
    for subdomain in aws_amplify_domain_association.main.sub_domain :
    subdomain.prefix => {
      dns_record = subdomain.dns_record
      verified   = subdomain.verified
    }
  }
  description = "DNS records for Amplify subdomains"
}

