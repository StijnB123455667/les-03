[test]
${hostname} ansible_host=${public_ip} ansible_user=${admin_username}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=~/.ssh/id_ed25519
