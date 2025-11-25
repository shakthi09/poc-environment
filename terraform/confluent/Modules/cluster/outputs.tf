output "cluster_id" {
  value = confluent_kafka_cluster.confluent.id
}

output "bootstrap_endpoint" {
  value = confluent_kafka_cluster.confluent.bootstrap_endpoint
}

output "rest_endpoint" {
  value = confluent_kafka_cluster.confluent.rest_endpoint
}

output "service_account_id" {
  value = confluent_service_account.app.id
}

output "kafka_api_key" {
  value = confluent_api_key.kafka.id
}

output "kafka_api_secret" {
  value     = confluent_api_key.kafka.secret
  sensitive = true
}

output "topics" {
  value = [for t in confluent_kafka_topic.topics : t.topic_name]
}