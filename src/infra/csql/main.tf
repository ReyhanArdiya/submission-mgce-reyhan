resource "google_sql_database_instance" "instance" {
  name             = "money-tracker-serv"
  region           = "asia-southeast2"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "Internet"
        value = "0.0.0.0/0"
      }
    }

  }

  deletion_protection = "false"
  root_password       = "123"
}

resource "google_sql_database" "database" {
  name     = "money-tracker"
  instance = google_sql_database_instance.instance.name

  #   provisioner "local-exec" {
  #     command = "mysql -h ${google_sql_database_instance.instance.ip_address.0.ip_address}"
  #   }
}

