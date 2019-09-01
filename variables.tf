variable "vsphere_server" {}
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_dc" {}
variable "vsphere_datastore_name" {}
#variable "vsphere_cluster" {}
variable "vsphere_resource" {}
variable "vsphere_rede" {}
variable "vsphere_qtd_hosts" {}
variable "vsphere_namevm" {
        type = "list"
        default = []
}
variable "vsphere_hostname" {
        type = "list"
        default = []
}
variable "vsphere_domain" {}
variable "vsphere_ip" {
        type = "list"
        default = []
}
variable "vsphere_ipmask" {}
variable "vsphere_gateway" {}
variable "vsphere_dns_domain" {}
variable "vsphere_dns_server_list" {}
variable "vsphere_cpus" {}
variable "vsphere_memory" {}
variable "vsphere_template" {}
