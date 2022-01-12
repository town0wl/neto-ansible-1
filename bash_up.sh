#!/bin/bash

hosts=(centos7 ubuntu fedora)

for i in ${hosts[@]}; do \
  if [[ -z $(docker ps -q -f name="$i") ]]; then \
    docker rm "$i";
    docker run --name "$i" -d pycontribs/alpine sleep 3000000;
  fi;
done

ansible-playbook -i inventory/prod.yml site.yml --vault-pass-file ~/.vault_pass.txt

for i in ${hosts[@]}; do \
  docker stop "$i";
  docker rm "$i";
done
