output "ilb_quotation_name" {
  description = "Internal Load Balancer Quotation Name."
  value       = module.ilb_quotation.forwarding_rule.name
}

output "ilb_transcription_name" {
  description = "Internal Load Balancer Transcription Name."
  value       = module.ilb_transcription.forwarding_rule.name
}