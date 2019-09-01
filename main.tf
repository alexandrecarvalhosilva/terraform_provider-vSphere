## Configure the vSphere Provider
provider "vsphere" {
    vsphere_server = "${var.vsphere_server}"
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    allow_unverified_ssl = true
}

## Build VM
data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_dc}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name		= "${var.vsphere_resource}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "mgmt_lan" {
  name          = "${var.vsphere_rede}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
resource "vsphere_virtual_machine" "cloned_virtual_machine" {
  count = "${var.vsphere_qtd_hosts}" 
  name             = "${element(var.vsphere_namevm,count.index)}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = "${var.vsphere_cpus}"
  memory   = "${var.vsphere_memory}"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
 
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}" 

network_interface {
    network_id   = "${data.vsphere_network.mgmt_lan.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
disk {
    label = "disck1"
    size = "20"
    unit_number = 1
  }
disk {
    label = "disck2"
    size = "80"
    unit_number = 2
  }

 
clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

 customize {
      timeout = "20"

      linux_options {
        host_name = "${element(var.vsphere_hostname,count.index)}"
        domain    = "${var.vsphere_domain}"
      }

      network_interface {
        ipv4_address = "${element(var.vsphere_ip,count.index)}"
        ipv4_netmask = "${var.vsphere_ipmask}"
      }

      ipv4_gateway    = "${var.vsphere_gateway}"
      dns_suffix_list = ["${var.vsphere_dns_domain}"]
      dns_server_list = ["${var.vsphere_dns_server_list}"]
    }

  }


}
