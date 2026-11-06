# 1. Configuracion del proveedor de AWS
provider "aws" {
  region = "us-east-1" # Region donde se desplegaran los recursos
}

# Crear un Security Group para la instancia
resource "aws_security_group" "mi-sg" {
  name        = "mi-security-group-terraform"
  description = "Security group para mi instancia de Terraform"
  vpc_id      = "vpc-0e98e541547cc6d96" # ID de la VPC donde se creara el grupo de seguridad
  #Reglas de entrada para el Security Group
  ingress {
    from_port   = 22 # Puerto SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Reglas de salida para el Security Group
  egress {
    from_port   = 80 # Puerto HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# 2. Configuracion de los recursos de AWS
resource "aws_instance" "mi_instancia_2" {
  ami           = "ami-0c230065b91270bc6" # ID de la imagen de Amazon Linux 2
  instance_type = "t3.large" # Tipo de instancia
  key_name      = "mi-primera-llaves-db" # Nombre del par de claves para acceder a la instancia
  security_groups = [aws_security_group.mi-sg.name] # Grupo de seguridad para la instancia
  vpc_security_group_ids = [aws_security_group.mi-sg.id] # Asignar el Security Group a la instancia

  tags = {
    Name = "MiInstanciaTerraform2" # Etiqueta para identificar la instancia
  }
}
