# Provisionamento de hosts no VMWare-vSphere para a instalação ambiente de homologação OKD 3.11 utilizando Terraform


## Infra-estrutura Ágil e Terraform

Antes de entendermos como funciona o Terraform é necessário compreender um pouco do que se trata infra-estrutura ágil e que tem a ver com isso. 

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

testexxxsdfsdf