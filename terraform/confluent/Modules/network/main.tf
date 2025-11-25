resource "confluent_network" "confluent" {
  display_name     = var.display_name
  cloud            = var.cloud
  region           = var.region
  connection_types = ["PRIVATELINK"]
  environment {
    id = var.environment_id
  }
}

resource "confluent_private_link_access" "azure" {
  display_name = "${var.display_name}-azure-access"

  environment {
    id = var.environment_id
  }

  network {
    id = confluent_network.confluent.id
  }

  azure {
    subscription = var.azure_subscription_id
  }
}
