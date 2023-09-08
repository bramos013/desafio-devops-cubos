# Desafio técnico - Cubos DevOps

Este é um documento com os materiais que serão disponibilizado para o desafio técnico.

## Objetivo

Crie um ambiente seguro utilizando infraestrutura como código onde existam
redes internas apenas acessíveis por certas aplicações e redes externas para
contato com o usuário. Esse ambiente deve ser replicável e subir
corretamente através de comandos de inicialização expostos no README
criado por você, todas as dependências para sua execução também devem
ser explicitadas, os usuários terão acesso a uma página HTML que se
conectará a um backend, este que por sua vez deverá ter acesso a um banco
de dados.

## Pré-requisitos

**Para provisionar o ambiente, você deverá utilizar as seguintes ferramentas:**
- [Docker](https://docs.docker.com/engine/install/);
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli);
- [Git](https://git-scm.com/downloads);

**Se estiver em ambiente Windows, utilizar:**
- [Docker Desktop](https://www.docker.com/products/docker-desktop);
- [WSL2](https://learn.microsoft.com/pt-br/windows/wsl/install);

**Ferramentas auxiliares opcionais:**
- [Gitkraken](https://www.gitkraken.com/download)(Client Git);
- [tfenv](https://github.com/tfutils/tfenv)(Gerenciador de versões do Terraform);

**Disponibilizei um shell script para verificar se as ferramentas estão instaladas.**

```bash
$ sh ./validate_requirements.sh
```

## Configuração

Após validar as ferramentas, você deverá configurar o ambiente para provisionar a infraestrutura.

Acesse o diretório `terraform` e execute o comando abaixo para inicializar o Terraform.

```bash
$ terraform init
```
Será criado um arquivo `terraform.tfstate` para armazenar o estado da infraestrutura, também será criado um diretório `.terraform` com os plugins necessários para o Terraform e um arquivo `terraform.lock.hcl` com as versões dos plugins.

Agora você podera executar o comando abaixo para visualizar o plano de execução da infraestrutura.

```bash
$ terraform plan
```
Após analisar o plano de execução, você poderá executar o comando abaixo para provisionar a infraestrutura.

```bash
$ terraform apply #Sera solicitado a confirmação da execução ou
$ terraform apply --auto-approve #Executa sem solicitar confirmação
```
Feito isso, aguardar a execução do Terraform e a infraestrutura estará pronta para uso.

## Recursos provisionados

<details>
<summary><strong>IMAGES</strong></summary>

```hcl
- cubos-frontend;
- cubos-backend; 
- cubos-sql;
- cubos-grafana;
- cubos-prometheus
```
</details>
<details>
<summary><strong>CONTAINERS</strong></summary>

```hcl
- cubos-frontend;
- cubos-backend;
- cubos-sql;
- cubos-grafana;
- cubos-prometheus
```
</details>
<details>
<summary><strong>NETWORKS</strong></summary>

```hcl
- monitoring-network(bridge); 
- sql-network(bridge);
- frontend-network;

# Redes em modo bridge para manter a comunicação entre os containers.
# A rede frontend-network é a única rede que permite o acesso externo.
```
</details>   
<details>
<summary><strong>VOLUMES</strong></summary>

```hcl
- sql-data;	
- sql-logs;
- sql-init;
- prometheus-data;

# Volumes criados para persistir os dados dos containers.
```
</details>

### Endpoints

- [http://localhost](http://localhost:80) - **Frontend** (Acesso visível externamente);
- [http://cubos-backend:3001](http://cubos-backend:3001) - **Backend**(Acesso restrito a rede interna sql-network);
- [http://cubos-sql:5432](http://cubos-sql:5432) - **Backend**(Acesso restrito a rede interna sql-network);
- [http://localhost:3000](http://localhost:3000) - **Grafana** (Acesso visível externamente);
- [http://localhost:9090](http://localhost:9090) - **Prometheus** (Acesso visível externamente);


Caso queira destruir a infraestrutura, execute o comando abaixo **(ATENÇÃO AO EXECUTAR A AÇÃO)**.

```bash
$ terraform destroy #Sera solicitado a confirmação da execução ou
$ terraform destroy --auto-approve #Executa sem solicitar confirmação
```

## AJUSTES REALIZADOS

<details>
<summary><strong>Backend</strong></summary>

```hcl
- Adicionada a lib dotenv para utilizar variáveis de ambiente;
- Adicionada as variáveis da string de conexão do banco de dados;
- Adicionada a variável $database para acessar apenas a base da aplicação;
- Adicionada a variável $port para executar o backend e evitar conflito com a porta do grafana;
- Removida a exposição da porta 3001 para evitar acesso externo;
```
</details>
<details>
<summary><strong>Frontend</strong></summary>

```hcl
- Para acessar o backend, escolhi uma imagem do nginx e adicionei o arquivo cubos.conf no diretório /etc/nginx/conf.d/;
- No arquivo cubos.conf, adicionei o proxy_pass para o backend através da rota api/;
```
</details>
<details>
<summary><strong>Sql</strong></summary>

```hcl
- Crie 3 volumes para persistir os dados do banco de dados;
- um volume para persistir os dados do banco de dados;
- um volume para persistir os logs do banco de dados;
- um volume para persistir o script de inicialização do banco de dados;
- Removi a exposição da porta 5432 para evitar acesso externo;
```
</details>
<details>
<summary><strong>Terraform</strong></summary>

```hcl
- Optei por organizar o código em uma espécie de módulos;
- Facilitando a manutenção e reutilização do código;
- Também visando a escalabilidade da infraestrutura;
- Criei o arquivo variaveis.tf e pensei em subir no repositório utilizando os secrets do Github(Pendente);
```
</details>

## Extras
 - Ambiente de monitoramento com Prometheus e Grafana
    - Subi os containers, realizei a configuração e comunicação entre as instâncias da infra;
    - Porém ficou pendente a configuração do datasource do Grafana com as métricas do Prometheus;
 - Utilizar SSL
    - Por se tratar de um ambiente web com conexão a banco de dados, optei por utilizar SSL;
    - Porém como o ambiente é local, utilizei o certificado auto-assinado, só que os navegadores 
   não reconhecem esse tipo de certificado como confiável;
    - Por este motivo, optei por não utilizar SSL;
 - Inseri um docker-compose.yml para subir os containers localmente, visando facilitar a execução do projeto;

***Obrigado pela oportunidade!***

**Sigo a disposição em caso de dúvidas** 
- [Linkedin](https://www.linkedin.com/in/sr1bramos/)
- [E-mail](mailto:brunoramos013@gmail.com)
