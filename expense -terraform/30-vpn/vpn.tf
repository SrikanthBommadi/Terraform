resource "aws_instance" "openvpn" {
  ami                    =  data.aws_ami.openvpn.id                 # This is open vpi devops-practice AMI ID
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  key_name = aws_key_pair.openkey.key_name
  instance_type          = "t3.micro"
  subnet_id = local.public_subnet_id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}

resource "aws_key_pair" "openkey" {
  key_name   = "opevpnkey"
  public_key = file("C:\\Users\\bomma\\OneDrive\\Desktop\\devops learning\\openvpnas.pub")
}

output "vpn_ip" {
  value       = aws_instance.openvpn.public_ip
}