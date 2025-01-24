# Make sure copy our private pem key here, otherwise it through an error

resource "null_resource" "cluster" {
  count = (var.env == "uat" ? 3 : 1)

  provisioner "file" { # This file provisioner copies the file from the local machine to the remote machine, in this case, the EC2 instance.
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"                                           # Ensure this is the correct user for your AMI
      host        = aws_instance.Public_servers[count.index].public_ip # Correctly reference the instance subnet_id
      private_key = file("Ravi_Virginia.pem")                          # Use the file function to read the private key
    }
  }

  provisioner "remote-exec" { # This remote-exec provisioner is used to execute commands on the remote machine, in this case, the EC2 instance.
    inline = [
      "sudo chmod 755 /tmp/user-data.sh",
      "sudo /tmp/user-data.sh",
      "sudo apt update",
      "sudo apt install jq unzip -y"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"                                           # Ensure this is the correct user for your AMI
      private_key = file("Ravi_Virginia.pem")                          # Use the file function to read the private key
      host        = aws_instance.Public_servers[count.index].public_ip # Correctly reference the instance subnet
    }
  }

}
