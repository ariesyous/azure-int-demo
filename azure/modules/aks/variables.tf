# General variables 
variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}

variable "location" {
  description = "The data center location where all resources will be put into."
  type        = string
}

variable "common_name_prefix" {
  description = "The prefix used to name all resources created."
  type        = string
}

variable "number" {
  description = "The count of the resource"
  default     = "001"
}

variable "name" {
  description = "The resoursce name to allocate."
  type        = string
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

#aks cluster variables 
variable "kubernetes_version" {
  default = ""
}

variable "dns_prefix" {
  description = "The prefix for the resources created in the specified Azure Resource Group."
  type        = string
  default     = ""
}
variable "private_cluster_enabled" {
  description = " Kubernetes Cluster have it's API server only exposed on internal IP addresses"
  type        = bool
  default     = false
}
variable "admin_username" {
  default     = "azureuser"
  description = "The username of the local administrator to be created on the Kubernetes cluster"
  type        = string
}

variable "public_ssh_key" {
  description = "A custom ssh key to control access to the AKS cluster"
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

# default node pool 
variable "node_type" {
  default     = "VirtualMachineScaleSets"
  description = "The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets"
  type        = string

}
variable "initial_node_count" {
  description = "The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 and between min_count and max_count"
  default     = 3
  type        = number

}
variable "node_size" {
  default     = "Standard_D2s_v3"
  description = "The default virtual machine size for the Kubernetes agents"
  type        = string
}
variable "os_disk_size_gb" {
  description = "Disk size of nodes in GBs."
  type        = number
  default     = 50
}
variable "vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist"
  type        = string
  default     = null
}
variable "enable_auto_scaling" {
  description = "default value is set to false."
  type        = string
  default     = false
}
variable "node_min_count" {
  description = "The maximum number of nodes which should exist in this Node Pool"
  type        = number
  default     = null
}
variable "node_max_count" {
  description = "The minimum number of nodes which should exist in this Node Pool"
  type        = number
  default     = null
}
variable "max_pods" {
  description = "The maximum number of pods that can run on each agent"
  type        = number
  default     = null
}

# addon_profile variables
variable "enable_http_application_routing" {
  description = "Enable HTTP Application Routing Addon (forces recreation)."
  type        = bool
  default     = false
}
variable "enabled_oms_agent" {
  description = "enable if you want monitoring in aks"
  type        = bool
  default     = true
}

variable "enabled_aci_connector_linux" {
  description = "for configuring the virtul nodes"
  type        = bool
  default     = false
}
variable "subnet_name" {
  description = "The subnet name for the virtual nodes to run."
  type        = string
  default     = ""
}

# network_profile variables

variable "network_plugin" {
  description = "Network plugin to use for networking. Currently supported values are azure and kubenet"
  type        = string
  default     = "azure"
}

variable "dns_service_ip" {
  description = " IP address within the Kubernetes service address range that will be used by cluster service discovery"
  type        = string
  default     = ""
}

variable "docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes"
  type        = string
  default     = ""
}

variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service"
  type        = string
  default     = ""
}

# variable "network_policy" {
#   description = "Sets up network policy to be used with Azure CNI"
#   type        = string
#   default     = "azure"
# }

variable "outbound_type" {
  description = "he outbound (egress) routing method which should be used for this Kubernetes Cluster"
  type        = string
  default     = "loadBalancer"
}

# variable "pod_cidr" {
#   description = "This field can only be set when network_plugin is set to kubenet"
#   type        = string
#   default     = ""
# }

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard"
  type        = string
  default     = "standard"
}

#service principal 
variable "client_id" {
  description = "The Client ID (appId) for the Service Principal used for the AKS deployment"
  type        = string
}

variable "client_secret" {
  description = "The Client Secret (password) for the Service Principal used for the AKS deployment"
  type        = string
}


# analytics variables 
variable "log_analytics_workspace_sku" {
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  description = "The retention period for the logs in days"
  type        = number
  default     = 30
}

#rbac variables 
variable "role_based_access_control" {
  description = "rbac enabled in aks cluster"
  type        = bool
  default     = true
}

#AD integration 
variable "azure_active_directory_enabled" {
  description = "managed ad integtaion  in aks cluster"
  type        = bool
  default     = true
}

variable "admin_group_object_ids" {
  description = "list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  type        = list(string)
  default     = []
}


#ingress
variable "ingress_application_gateway_enabled" {
  description = "enable ingress gateway for the cluster"
  type        = bool
  default     = false
}

#Gateway ID
variable "ingress_application_gateway_id" {
  type = string
  default = null
}
