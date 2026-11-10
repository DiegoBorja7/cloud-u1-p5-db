resource "aws_security_group" "sg_windows" {
  name        = "security-group-para-windows"
  description = "Security group para Windows - Tarea 4"
  vpc_id      = "vpc-0e98e541547cc6d96" # ID de la VPC donde se creara el grupo de seguridad
  #Reglas de entrada para el Security Group
  ingress {
    from_port   =3389  # Puerto RDP
    to_port     = 3389
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

resource "aws_instance" "instancia_windows" {
  ami           = "ami-0b16ced290e00a1a3" # ID de la imagen de Windows Server 2019 Base
  instance_type = "t3.large" # Tipo de instancia
  key_name      = "mi-segunda-llaves" # Nombre del par de claves para acceder a la instancia
  security_groups = [aws_security_group.sg_windows.name] # Grupo de seguridad para la instancia
  vpc_security_group_ids = [aws_security_group.sg_windows.id] # Asignar el Security Group a la instancia

  tags = {
    Name = "InstanciaWindowsConTerraform-Tarea4" # Etiqueta para identificar la instancia
  }
}