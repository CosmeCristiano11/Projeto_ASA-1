#!/bin/bash

# Gera hosts.ini dinâmico com base nas VMs ativas
echo "# Gerado automaticamente" > hosts.ini

for vm in arq db app cli; do
  echo "[${vm}]" >> hosts.ini

  # extrai IP da interface eth1 (rede interna)
  ip=$(vagrant ssh "$vm" -c "ip -4 a show eth1 | grep inet | awk '{print \$2}' | cut -d/ -f1" 2>/dev/null | tr -d '\r')

  # extrai caminho da chave privada
  key=".vagrant/machines/${vm}/virtualbox/private_key"

  # escreve no hosts.ini
  if [[ -n "$ip" && -f "$key" ]]; then
    echo "${ip} ansible_user=vagrant ansible_ssh_private_key_file=${key}" >> hosts.ini
  else
    echo "# ${vm} sem IP ou chave" >> hosts.ini
  fi

  echo "" >> hosts.ini
done

echo " Arquivo hosts.ini atualizado com sucesso."

