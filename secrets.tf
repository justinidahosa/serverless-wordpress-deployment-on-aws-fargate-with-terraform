resource "aws_secretsmanager_secret" "wordpress_credentials" {
  name                    = "wordpress-credentials"
  description             = "credentials for the wordpress database"
}

resource "aws_secretsmanager_secret_version" "wordpress_credentials_version" {
  secret_id     = aws_secretsmanager_secret.wordpress_credentials.id
  secret_string = jsonencode({
    username = "admin"
    password = "september30"
  })
}