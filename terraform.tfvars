#################################################3##############
######Informações referentes ao VMWare - vSphere ###############
################################################################
vsphere_server = "homolvc.cjf.homol"
vsphere_user = "administrator@vsphere.homol"
vsphere_password = "HOMOLcjf@123"
vsphere_dc = "HOMOL-DC"
vsphere_datastore_name = "FC_SATA_vSPHERE_HOMOL_01"
#vsphere_cluster= "Gen10_HOMOL"
vsphere_resource= "OPENSHIFT"
vsphere_rede= "HOMOL-Gerencia"
#################################################################
# Inforações refrente as maquinas virtuais que seram criadas ####
# Qts hots VMs: 9
# CPUs: 8
# Memoria: 16GB
# Disco01 (SO): 60GB
# Disco02 (Docker-sotorage): 20GB
# Disco03 (GlusterFS): 80GB
#######33########################################################
vsphere_qtd_hosts = 9
vsphere_namevm = ["master1","master2","master3","node1","node2","node3","node4","lb1","lb2"]
vsphere_hostname = ["master1","master2","master3","node1","node2","node3","node4","lb1","lb2"]
vsphere_domain = "apps.cjf.local"
vsphere_ip = ["10.4.250.26","10.4.250.27","10.4.250.28","10.4.250.29","10.4.250.30","10.4.250.31","10.4.250.32","10.4.250.33","10.4.250.34"]
vsphere_ipmask = "24"
vsphere_gateway = "10.4.250.254"
vsphere_dns_domain = "apps.cjf.local"
vsphere_dns_server_list = "10.4.250.25"
vsphere_cpus = "8"
vsphere_memory = "16384"
vsphere_template = "template_centos7"

