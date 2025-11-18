ingress_rules = {
  # --- YOUR NEW RULES ---
  "allow-internal-all-non-prod" = {
    description    = "Allow all ports from internal corporate network."
    source_ranges  = ["10.0.0.0/8"]
    rules          = [{ protocol = "all" }]
    target_network = "non-prod-host" # Target the non-prod network
  },
  "allow-internal-all-hub" = {
    description    = "Allow all ports from internal corporate network."
    source_ranges  = ["10.0.0.0/8"]
    rules          = [{ protocol = "all" }]
    target_network = "hub-network" # Target the hub network
  }
}