output "vpn_public_ip" {
  value       = aws_eip.this.public_ip
  description = "The public IP of the VPN EC2"
}
