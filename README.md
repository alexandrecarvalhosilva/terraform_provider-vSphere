# Provisionamento de hosts no VMWare-vSphere para a instalação ambiente de homologação OKD 3.11 utilizando Terraform


## Infra-estrutura Ágil e Terraform

Antes de entendermos como funciona o Terraform é necessário compreender um pouco do que se trata infra-estrutura ágil e onde o terraform se encaixa. 

### Infra-estrutura Ágil

Infra-estrutura Ágil é o pilar de Operação que viabiliza a adoção de cultura DevOps em uma empresa. O DevOps tem um escopo muito maior pois visa a união de Desenvolvedores e SysAdmins, enquanto a infra-estrutura ágil é um movimento que visa tornar a infra-estrutura automatizada, orquestrada, versionada, monitorada, sendo tudo provisionado como código. Desta forma torna-se possível falar sobre DevOps.

Para entendermos sobre infra-estrutura ágil precisamos compreender os 5 tipos de ferramentas:

- Ferramentas de controle de versão; 
- Ferramentas de gerenciamento de configuração; 
- Integração continua; 
- Orquestração; 
- Ferramentas para bootstrapping e provisionamento de infra-estrutura;

Ferramentas de controle de versão são ferramentas que registram as mudanças feitas em um arquivo ou um conjunto de arquivos ao longo do tempo, de forma que você possa recuperar versões específicas. Algumas delas são, git, subversion, mercurial, performace.

Ferramentas de gerenciamento de configuração servem para assegurar que os sistemas são como deveriam ser e estão em conformidade com os requisitos, ou seja, controlam o estado de um sistema, ajudam a centralizar as configurações, facilita a administração e a criação de novos ambientes como também verifica continuamente se alterações de configurações de sistemas são adequadamente validas. Algumas delas são. Puppet, ansible, chef e salt

Integração contínua (CI) é a prática de desenvolvimento de software que objetiva tornar a entrega do código mais eficiente, através de builds automatizadas e execução de tarefas definidas previamente como, por exemplo, testes automatizados. Jenkins, TeamCity, Go, etc. são algumas das ferramentas CI/CD disponíveis no mercado.

Orquestradores são ferramentas que nos permitem controlar instâncias/nodes de nosso parque em tempo real e a executar comandos. São exemplos de ferramentas de orquestração Fabric, Capistano, Func e Mcollective.

E por último as ferramentas de bootstrapping, objeto deste post, aquelas ferramentas que nos ajudam a instalar um sistema operacional, a criar uma infraestrutura, seja máquinas físicas ou virtuais, ou até um instância em cloud. 

### Terraform

Se compararmos o Puppet com o Terraform, o Terraform é responsável por criar a infra-estrutura que o Puppet irá gerenciar e o Puppet responsável por gerencial uma infra-estrutura que já existe.

Como exemplo temos Terraform, ferramenta opensource desenvolvida pela Hashicorps em 2014 pelo próprio Mitchell Hashimoto, ferramenta focada em provisionar infra-estrutura e bootstrapping, possui uma linguagem própria chamada HCL – Hashicorp Configuration Language, e opcionalmente pode ser usado JSON. 

O Terrraform possui diversos [Providers](https://www.terraform.io/docs/providers/index.html), segue alguns bem populares: AWS, DigitalOcean, GCE e Azure, VMWare. 

Apesar de ser considerado MultiCloud o Terraform não abstrai a infra-estrutura, ou seja, um arquivo terraform que provisiona uma instância na Azure é diferente de um arquivo que provisiona uma máquina na AWS por exemplo. Este conceito pode parecer que dificulta a coisa, mas, na verdade, facilita pois quanto maior a abstração maior a complexidade. 

Os arquivos de configuração são em formato texto que devem ser salvos em “.tf” para serem interpretados pelo terraform, possuem um formata específico da linguagem HCL. 

Antes de aplicar qualquer configuração é executado uma plano de execução que relaciona o que será feito caso seja aplicado o terraform. 

## Arquitetura
Para demonstrar o funcionamento do terraform será realizado o provisionamento de 9 máquinas virtuais no VMWare vSphere, estas máquinas seram utilizadas para criar o ambiente de homologação do OKD 3.11, segue a baixo informações da arquitetura necessária:

![Arquitetura](https://github.com/alexandrecarvalhosilva/terraform_provider-vSphere/blob/master/imagens/Desenho1.jpg)


| Hostname | IP Address  | Proc |  Mem   | Disk |
| -------- | ----------  | ---- |  ----  | ---- |
| infra    | 10.4.250.25 |   8  |  16GB  | 60GB,20GB e 80GB |
| master1  | 10.4.250.26 |   8  |  16GB  | 60GB,20GB e 80GB | 
| master2  | 10.4.250.27 |   8  |  16GB  | 60GB,20GB e 80GB |
| master3  | 10.4.250.28 |   8  |  16GB  | 60GB,20GB e 80GB |
|  node1   | 10.4.250.29 |   8  |  16GB  | 60GB,20GB e 80GB |
|  node2   | 10.4.250.30 |   8  |  16GB  | 60GB,20GB e 80GB |
|  node3   | 10.4.250.31 |   8  |  16GB  | 60GB,20GB e 80GB |
|  node4   | 10.4.250.32 |   8  |  16GB  | 60GB,20GB e 80GB |
|   lb1    | 10.4.250.33 |   8  |  16GB  | 60GB,20GB e 80GB |
|   lb2    | 10.4.250.35 |   8  |  16GB  | 60GB,20GB e 80GB |

# Instalação Terraform 

##### Baixar pacote
```sh
$ wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
```

##### Descompactar pacote
```sh
$ unzip ./terraform_0.11.13_linux_amd64.zip -d /usr/local/bin
```

##### Clonar repositorio
```sh
$ git clone https://github.com/alexandrecarvalhosilva/terraform_provider-vSphere.git
$ cd ./terraform_provider-vSphere
```
# Editar arquivos de configuração do terraform

##### Declarar variáveis, editar [variables.tf](https://github.com/alexandrecarvalhosilva/terraform_provider-vSphere/blob/master/variables.tf)
```sh
$ vim variables.tf
```
Neste arquivo são declarados as variáveis que serão utilizadas pelo Terraform e quais são os tipos de variáveis, neste exemplo utilizamos variáveis do tipo string,list e number.

##### Atribuir valores as variáveis declaradas, editar [terraform.tfvars](https://github.com/alexandrecarvalhosilva/terraform_provider-vSphere/blob/master/terraform.tfvars)
```sh
$ vim terraform.tfvars
```
O arquivo terraform.tfvars tem a função de atribuir valores às variáveis declaradas no arquivo variables.tf, com está separação em arquivos diferente viabiliza a execução de diferentes planos de provisionamentos. Exemplo: 
```sh
$ terraform apply -var-file="outro.tfvars"
```
##### Criar resourse e definir configurações, editar [main.tf](https://github.com/alexandrecarvalhosilva/terraform_provider-vSphere/blob/master/main.tf)
```sh
$ vim main.tf
```
É no aquivo main.tf que é instanciado o provider do vsphere e aplicado as configurações de acesso ao mesmo. Neste mesmo arquivo é realizado o clone do templete e aplicado as configurações especificas a cada host.

# Executando o Terraform