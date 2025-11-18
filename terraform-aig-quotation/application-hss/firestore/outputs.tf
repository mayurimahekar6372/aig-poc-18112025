output "firestore_database_name" {
  description = "Firestore Database Name."
  value       = module.firestore.firestore_database.name
}