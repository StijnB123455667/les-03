---
- name: Configureer test VM
  hosts: test
  become: true

  tasks:
    - name: Update apt cache
      ansible.builtin.apt:
        update_cache: true
        cache_valid_time: 3600

    - name: Upgrade alle packages op Ubuntu
      ansible.builtin.apt:
        upgrade: dist

    - name: Voeg ESXi host toe aan /etc/hosts
      ansible.builtin.lineinfile:
        path: /etc/hosts
        line: "{{ esxi_ip }} {{ esxi_hostname }}"
        regexp: "^{{ esxi_ip | regex_escape() }}\\s+{{ esxi_hostname }}$"
        state: present
        backup: true

    - name: Maak user test aan
      ansible.builtin.user:
        name: test
        shell: /bin/bash
        create_home: true
        state: present

    - name: Kopieer lokaal bestand naar VM
      ansible.builtin.copy:
        src: files/local-example.txt
        dest: "{{ local_file_destination }}"
        owner: root
        group: root
        mode: "0644"
