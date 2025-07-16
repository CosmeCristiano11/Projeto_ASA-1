# Projeto DevOps – Administração de Sistemas Abertos

Este projeto configura automaticamente um ambiente com múltiplas máquinas virtuais usando Vagrant e Ansible, simulando a implantação de serviços típicos em ambientes corporativos (DHCP, NFS, LVM, MariaDB, Apache, entre outros). Ele é adaptável e pode ser executado em qualquer host com VirtualBox e Vagrant instalados.

##  Tecnologias utilizadas

- Vagrant (orquestração de máquinas)
- Ansible (provisionamento e automação)
- Debian Bookworm (sistema base)
- Serviços:
  - Servidor DHCP (isc-dhcp-server)
  - Servidor NFS (nfs-kernel-server)
  - Volume lógico (LVM)
  - MariaDB
  - Apache2 (web server)
  - autofs
  - Firefox (no cliente gráfico)

## Arquitetura de Máquinas

| Nome | Função | IP atribuído | Serviços |
|------|--------|---------------|----------|
| arq  | Servidor de arquivos | 192.168.56.236 (fixo) | DHCP, LVM, NFS |
| db   | Banco de dados       | DHCP                   | MariaDB, autofs |
| app  | Aplicação Web        | DHCP                   | Apache2, autofs |
| cli  | Cliente gráfico      | DHCP                   | Firefox, autofs, X11 |

##  Estrutura de diretórios

projeto-devops/
├── Vagrantfile
├── ansible.cfg
├── hosts.ini (gerado dinamicamente)
├── gerar_hosts_ini.sh
├── playbooks/
│ ├── common.yml
│ ├── ssh.yml
│ ├── arq.yml
│ ├── db.yml
│ ├── app.yml
│ └── cli.yml
├── roles/
│ ├── apache/
│ ├── autofs/
│ ├── cliente/
│ ├── common/
│ ├── dhcp/
│ ├── lvm/
│ ├── mariadb/
│ ├── nfs/
│ └── ssh/
└── README.md


## Como executar

1. Clone o repositório:


git clone https://github.com/CosmeCristiano11/Projeto_ASA.git
cd Projeto_ASA

2. Suba as Máquinas

vagrant up

3. Gere o arquivo hosts.ini

./gerar_hosts_ini.sh

4. Execute os Playbooks

ansible-playbook playbooks/common.yml
ansible-playbook playbooks/ssh.yml
ansible-playbook playbooks/arq.yml
ansible-playbook playbooks/db.yml
ansible-playbook playbooks/app.yml
ansible-playbook playbooks/cli.yml

Verificações e testes

    SSH com chave pública sem senha

    Login sudo para usuários caua e cosme sem senha

    NFS montado automaticamente em /var/nfs/dados

    Apache disponível via http://<IP_app>

    MariaDB acessível localmente em db

    Firefox executando remotamente via SSH/X11 do cliente CLI  
