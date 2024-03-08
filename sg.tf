resource "aws_security_group" "lb_security_group" {
  name        = "lb-ssh-security-group"
  description = "Security group for allowing SSH traffic to the NLB"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this to limit access based on your network requirements
  }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Reference the security group of the instance
  }
}

resource "aws_security_group" "instance_security_group" {
  name        = "instance-security-group"
  description = "Security group for allowing SSH traffic to the NLB"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_security_group.id]
}
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Reference the security group of the instance
  }
}