module "vpn_ha" {
  source = "../modules/net-vpn-ha"
  project_id = data.terraform_remote_state.projects.outputs.hub_network_project_id
  region = var.region
  network = data.terraform_remote_state.networking.outputs.hub_vpc_self_link
  name = var.vpn_gateway_name
  peer_gateways = {
    default = {
      external = {
        redundancy_type = "SINGLE_IP_INTERNALLY_REDUNDANT"
        interfaces      = ["170.105.8.35"] # on-prem router ip address
      }
    }
  }
  router_config = var.router_config
  # tunnels = {
  #   remote-0 = {
  #     bgp_peer = {
  #       address = "169.254.1.1"
  #       asn     = 64513
  #       # BFD is optional
  #       bfd = {
  #         min_receive_interval        = 1000
  #         min_transmit_interval       = 1000
  #         multiplier                  = 5
  #         session_initialization_mode = "ACTIVE"
  #       }
  #       # MD5 Authentication is optional
  #       md5_authentication_key = {
  #         name = "foo"
  #         key  = "bar"
  #       }
  #     }
  #     bgp_session_range               = "169.254.1.2/30"
  #     peer_external_gateway_interface = 0
  #     shared_secret                   = "mySecret"
  #     vpn_gateway_interface           = 0
  #   }
  #   # remote-1 = {
  #   #   bgp_peer = {
  #   #     address = "169.254.2.1"
  #   #     asn     = 64513
  #   #     # BFD is optional
  #   #     bfd = {
  #   #       min_receive_interval        = 1000
  #   #       min_transmit_interval       = 1000
  #   #       multiplier                  = 5
  #   #       session_initialization_mode = "ACTIVE"
  #   #     }
  #   #     # MD5 Authentication is optional
  #   #     md5_authentication_key = {
  #   #       name = "foo"
  #   #       key  = "bar"
  #   #     }
  #   #   }
  #   #   bgp_session_range               = "169.254.2.2/30"
  #   #   peer_external_gateway_interface = 0
  #   #   shared_secret                   = "mySecret"
  #   #   vpn_gateway_interface           = 1
  #   # }
  # }
}


