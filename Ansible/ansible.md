# Ansible

![image](https://github.com/user-attachments/assets/ae45e473-ff07-4d5d-acb1-70bdcbdb84a4)



# Installation Steps:

````
sudo apt-add-repository ppa:ansible/ansible
````
````
sudo apt update
````
````
sudo apt install ansible
````
````
ansible --version
````
### set up inventory file

````
sudo nano /etc/ansible/hosts
private-ip of instance
````

### edit ansible.cfg

````
[defaults]
inventory = hosts
host_key_checking = False
````


### ping all nodes to test connection
````
ansible all -m ping
````
### run playbook
````
ansible-playbook playbook.yaml
````
