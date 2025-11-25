# Kafka cluster
resource "confluent_kafka_cluster" "confluent" {
  display_name = var.cluster_name
  cloud        = var.cloud
  region       = var.region
  availability = var.availability

  basic {} 

  environment {
    id = var.environment_id
  }

  network {
    id = var.network_id
  }
}

# Service account for application
resource "confluent_service_account" "app" {
  display_name = var.service_account_name
  description  = var.service_account_description
}

# Kafka API key for this cluster
resource "confluent_api_key" "kafka" {
  display_name = "${var.cluster_name}-poc-key"
  description  = "Kafka API key for POC service account"

  environment {
    id = var.environment_id
  }

  kafka_cluster {
    id = confluent_kafka_cluster.confluent.id
  }

  owner {
    id          = confluent_service_account.app.id
    api_version = "iam.v2.ServiceAccount"
    kind        = "ServiceAccount"
  }
}

# Create topics using REST endpoint & credentials
resource "confluent_kafka_topic" "topics" {
  for_each = toset(var.topics)

  topic_name       = each.value
  partitions_count = 3

  kafka_cluster {
    id = confluent_kafka_cluster.confluent.id
  }

  rest_endpoint = confluent_kafka_cluster.confluent.rest_endpoint

  credentials {
    key    = confluent_api_key.kafka.id
    secret = confluent_api_key.kafka.secret
  }
}

# ACLs: allow service account to READ and WRITE all specified topics
resource "confluent_kafka_acl" "write_topics" {
  for_each = confluent_kafka_topic.topics

  kafka_cluster {
    id = confluent_kafka_cluster.confluent.id
  }

  rest_endpoint = confluent_kafka_cluster.confluent.rest_endpoint

  resource_type = "TOPIC"
  resource_name = each.value.topic_name
  pattern_type  = "LITERAL"

  principal  = local.principal
  host       = "*"
  operation  = "WRITE"
  permission = "ALLOW"

  credentials {
    key    = confluent_api_key.kafka.id
    secret = confluent_api_key.kafka.secret
  }
}

resource "confluent_kafka_acl" "read_topics" {
  for_each = confluent_kafka_topic.topics

  kafka_cluster {
    id = confluent_kafka_cluster.confluent.id
  }

  rest_endpoint = confluent_kafka_cluster.confluent.rest_endpoint

  resource_type = "TOPIC"
  resource_name = each.value.topic_name
  pattern_type  = "LITERAL"

  principal  = local.principal
  host       = "*"
  operation  = "READ"
  permission = "ALLOW"

  credentials {
    key    = confluent_api_key.kafka.id
    secret = confluent_api_key.kafka.secret
  }
}
