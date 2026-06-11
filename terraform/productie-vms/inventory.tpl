[webservers]
%{ for name, ip in webservers ~}
${name} ansible_host=${ip} ansible_user=${admin_username}
%{ endfor ~}

[databases]
%{ for name, ip in databases ~}
${name} ansible_host=${ip} ansible_user=${admin_username}
%{ endfor ~}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=~/.ssh/id_ed25519
