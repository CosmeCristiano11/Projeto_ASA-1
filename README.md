# Projeto DevOps — Administração de Sistemas Abertos (IFPB)

Este projeto tem como objetivo automatizar a criação e configuração de uma infraestrutura DevOps com múltiplos servidores usando Vagrant e Ansible. O ambiente provisionado simula serviços de rede com foco em práticas de Administração de Sistemas Abertos, incluindo: DHCP, LVM, NFS, MariaDB, Apache, Autofs, SSH seguro e acesso remoto gráfico com Firefox via X11.

---

## Integrantes:

- Cauã Pablo Miguel Vicente da Silva — Matrícula: 20232380036  
- Cosme Cristiano Ferreira de Jesus — Matrícula: 20232380020

---

##  Objetivo:

- Provisionar quatro máquinas virtuais integradas em rede privada
- Automatizar a configuração de serviços usando Ansible
- Promover boas práticas de segurança e gerenciamento de infraestrutura
- Integrar serviços em diferentes VMs (NFS, Apache, MariaDB etc.)
- Viabilizar testes com interface gráfica remota (Firefox via SSH + X11)

---

##  Tecnologias Utilizadas:

- Vagrant + VirtualBox  
- Debian GNU/Linux 12 (Bookworm)  
- Ansible  
- Serviços: DHCP, NFS, LVM, Apache, MariaDB, Autofs, Chrony, SSH, Firefox, X11

---

##  Topologia da Infraestrutura:

| VM    | Hostname               | IP Estático ou DHCP | Função                                    |
|-------|------------------------|---------------------|-------------------------------------------|
| arq   | arq.caua.cosme.devops  | 192.168.56.236      | Servidor DHCP, NFS e LVM                  |
| db    | db.caua.cosme.devops   | 192.168.56.3        | Banco de dados MariaDB + autofs           |
| app   | app.caua.cosme.devops  | 192.168.56.10       | Servidor web Apache + autofs              |
| cli   | cli.caua.cosme.devops  | 192.168.56.13       | Cliente gráfico com Firefox + X11 + autofs |

---

## Estrutura do Projeto: 

## Projeto_ASA/
     Vagrantfile # Define as VMs, IPs e discos
     ansible.cfg # Configuração geral do Ansible
     hosts.ini # Inventário com IPs e grupos
## playbooks/
    common.yml # Atualizações e usuários
    ssh.yml # SSH seguro e sudo
    arq.yml # DHCP, LVM, NFS
    db.yml # MariaDB + autofs
    app.yml # Apache + autofs
    cli.yml # Firefox, X11, autofs
## roles/
    common/
    ssh/
    dhcp/
    lvm/
    nfs/
    mariadb/
    apache/
    autofs/
    cliente/
README.md

## Execução do Projeto:

1 - Clone o repositório:
    git clone https://github.com/CosmeCristiano11/Projeto_ASA-1.git
    cd Projeto_ASA-1

2 - Suba as VMs:
    
    vagrant up arq
## Agurde o DHCP iniciar 
    vagrant up db
    vagrant up app
    vagrant up cli

3 - Execute os plabooks na ordem correta:

    ansible-playbook -i hosts.ini playbooks/common.yml
    ansible-playbook -i hosts.ini playbooks/ssh.yml
    ansible-playbook -i hosts.ini playbooks/arq.yml
    ansible-playbook -i hosts.ini playbooks/db.yml
    ansible-playbook -i hosts.ini playbooks/app.yml
    ansible-playbook -i hosts.ini playbooks/cli.yml

Validação:

    Apache: Acesse http://192.168.56.10 e veja a página HTML com o nome da equipe.

NFS + autofs:

    Em db, app ou cli:
    ls /var/nfs/dados

SSH + X11

Do host, execute:
ssh -X -i ~/.vagrant.d/insecure_private_key vagrant@192.168.56.13
firefox &

Segurança:

    Login via root está bloqueado.
    Apenas grupos ifpb e vagrant têm acesso via SSH.
    Acesso ao NFS é permitido apenas para ao usuário nfs-ifpb
