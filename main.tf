resource "oci_core_vcn" "vcn" {
    compartment_id  = var.compartment_id
    cidr_blocks     = [var.cidr_block]
    display_name    = "${var.environment}-vcn"
    dns_label       = "dev"
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    is_ipv6enabled  = false
}

resource "oci_core_internet_gateway" "internet_gateway" {
    compartment_id      = var.compartment_id
    vcn_id              = oci_core_vcn.vcn.id

    enabled = true
    display_name = "${var.environment}-ig"
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
}

resource "oci_core_route_table" "public_route_table" {
    compartment_id      = var.compartment_id
    vcn_id              = oci_core_vcn.vcn.id

    display_name        = "${var.environment}-public-rt"
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    route_rules {
        network_entity_id   = oci_core_internet_gateway.internet_gateway.id
        description         = "Allow Public Subnet access anywhere through Internet Gateway"
        destination         = "0.0.0.0/0"
        destination_type    = "CIDR_BLOCK"
    }
}

resource "oci_core_security_list" "public_security_list" {
    compartment_id      = var.compartment_id
    vcn_id              = oci_core_vcn.vcn.id
    display_name        = "${var.environment}-public-sl"
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    ingress_security_rules {
        stateless   = false
        source      = var.cidr_block
        source_type = "CIDR_BLOCK"
        protocol    = "all"
    }
    ingress_security_rules {
        stateless   = false
        source      = var.public_ip_address
        source_type = "CIDR_BLOCK"
        protocol    = "all"
    }
    egress_security_rules {
        stateless        = false
        destination      = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        protocol         = "all"
    }
}

resource "oci_core_subnet" "public_subnet" {
    cidr_block                      = var.cidr_block_public
    compartment_id                  = var.compartment_id
    vcn_id                          = oci_core_vcn.vcn.id
    display_name                    = "${var.environment}-public-subnet"
    dns_label                       = "public"
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    prohibit_internet_ingress       = false
    prohibit_public_ip_on_vnic      = false
    route_table_id                  = oci_core_route_table.public_route_table.id
    security_list_ids               = [oci_core_security_list.public_security_list.id]
}

resource "oci_core_subnet" "pods_subnet" {
    cidr_block                      = var.cidr_block_pods
    compartment_id                  = var.compartment_id
    vcn_id                          = oci_core_vcn.vcn.id
    display_name                    = "${var.environment}-pods-subnet"
    dns_label                       = "pods"
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    prohibit_internet_ingress       = false
    prohibit_public_ip_on_vnic      = false
    route_table_id                  = oci_core_route_table.public_route_table.id
    security_list_ids               = [oci_core_security_list.public_security_list.id]
}

resource "oci_core_subnet" "lbs_subnet" {
    cidr_block                      = var.cidr_block_lbs
    compartment_id                  = var.compartment_id
    vcn_id                          = oci_core_vcn.vcn.id
    display_name                    = "${var.environment}-lbs-subnet"
    dns_label                       = "lbs"
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    prohibit_internet_ingress       = false
    prohibit_public_ip_on_vnic      = false
    route_table_id                  = oci_core_route_table.public_route_table.id
    security_list_ids               = [oci_core_security_list.public_security_list.id]
}

resource "oci_core_subnet" "nodes_subnet" {
    cidr_block                      = var.cidr_block_nodes
    compartment_id                  = var.compartment_id
    vcn_id                          = oci_core_vcn.vcn.id
    display_name                    = "${var.environment}-nodes-subnet"
    dns_label                       = "nodes"
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    prohibit_internet_ingress       = false
    prohibit_public_ip_on_vnic      = false
    route_table_id                  = oci_core_route_table.public_route_table.id
    security_list_ids               = [oci_core_security_list.public_security_list.id]
}

resource "oci_core_network_security_group" "nodes_nsg" {
    compartment_id      = var.compartment_id
    vcn_id              = oci_core_vcn.vcn.id
    display_name        = "${var.environment}-nodes-nsg"
    freeform_tags       = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
}

resource "oci_core_network_security_group" "pods_nsg" {
    compartment_id      = var.compartment_id
    vcn_id              = oci_core_vcn.vcn.id
    display_name        = "${var.environment}-pods-nsg"
    freeform_tags       = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
}

resource "oci_core_network_security_group" "lbs_nsg" {
    compartment_id      = var.compartment_id
    vcn_id              = oci_core_vcn.vcn.id
    display_name        = "${var.environment}-lbs-nsg"
    freeform_tags       = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
}

resource "oci_core_network_security_group" "oke_nsg" {
    compartment_id      = var.compartment_id
    vcn_id              = oci_core_vcn.vcn.id
    display_name        = "${var.environment}-oke-nsg"
    freeform_tags       = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
}

resource "oci_core_network_security_group_security_rule" "oke_nsg_rule" {
    network_security_group_id = oci_core_network_security_group.oke_nsg.id
    direction = "INGRESS"
    protocol = "all"
    description = "Security Rules to OKE Network Security Group"
    source = var.public_ip_address
    source_type = "CIDR_BLOCK"
    stateless = false
}

resource "oci_core_network_security_group_security_rule" "nodes_nsg_rule" {
    network_security_group_id = oci_core_network_security_group.nodes_nsg.id
    direction = "INGRESS"
    protocol = "all"
    description = "Security Rules to OKE Nodes Network Security Group"
    source = var.public_ip_address
    source_type = "CIDR_BLOCK"
    stateless = false
}

resource "oci_containerengine_cluster" "k8s_cluster" {
    compartment_id      = var.compartment_id
    kubernetes_version  = "v1.24.1"
    name                = "${var.environment}-cluster"
    vcn_id              = oci_core_vcn.vcn.id

    cluster_pod_network_options {
        cni_type = "OCI_VCN_IP_NATIVE"
    }
    endpoint_config {
        is_public_ip_enabled    = true
        nsg_ids                 = [oci_core_network_security_group.oke_nsg.id]
        subnet_id               = oci_core_subnet.public_subnet.id
    }
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    options {
        add_ons {
            is_kubernetes_dashboard_enabled = true
            is_tiller_enabled               = false
        }
        kubernetes_network_config {
            pods_cidr           = "10.244.0.0/16"
            services_cidr       = "10.96.0.0/16"
        }
        persistent_volume_config {
            freeform_tags       = {
                "Environment"   = "${var.environment}",
                "CostCenter"    = "${var.cost_center}"
            }
        }
        service_lb_config {
            freeform_tags   = {
                "Environment"   = "${var.environment}",
                "CostCenter"    = "${var.cost_center}"
            }
        }
        service_lb_subnet_ids = [oci_core_subnet.lbs_subnet.id]
    }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id    = var.compartment_id
}

resource "oci_containerengine_node_pool" "k8s_node_pool_public" {
    cluster_id          = oci_containerengine_cluster.k8s_cluster.id
    compartment_id      = var.compartment_id
    name                = "${var.environment}-nodepool-public"
    node_shape          = "VM.Standard.A1.Flex"
    freeform_tags       = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    initial_node_labels {
        key             = "name"
        value           = "${var.environment}"
    }
    kubernetes_version  = "v1.24.1"
    node_config_details {
        placement_configs {
            availability_domain     = data.oci_identity_availability_domains.ads.availability_domains[0].name
            subnet_id               = oci_core_subnet.nodes_subnet.id
        }
        placement_configs {
            availability_domain     = data.oci_identity_availability_domains.ads.availability_domains[1].name
            subnet_id               = oci_core_subnet.nodes_subnet.id
        }
        placement_configs {
            availability_domain     = data.oci_identity_availability_domains.ads.availability_domains[2].name
            subnet_id               = oci_core_subnet.nodes_subnet.id
        }
        size = 2
        is_pv_encryption_in_transit_enabled = false
        node_pool_pod_network_option_details {
            cni_type = "OCI_VCN_IP_NATIVE"
            max_pods_per_node = 31
            pod_nsg_ids = [oci_core_network_security_group.pods_nsg.id]
            pod_subnet_ids = [oci_core_subnet.pods_subnet.id]
        }
        freeform_tags   = {
            "Environment"   = "${var.environment}",
            "CostCenter"    = "${var.cost_center}"
        }
        nsg_ids = [oci_core_network_security_group.nodes_nsg.id]
    }
    node_eviction_node_pool_settings {
        eviction_grace_duration = "PT0S"
    }
    node_shape_config {
        memory_in_gbs = 12
        ocpus = 2
    }
    node_source_details {
        # Oracle-Linux-8.6-aarch64-2022.06.30-0-OKE-1.24.1-417
        image_id = "ocid1.image.oc1.iad.aaaaaaaadl5lond67wh3qx64qjpzh2apqmnranxaorhww3vlxxoipjqa53lq"
        source_type = "image"
        boot_volume_size_in_gbs = 50
    }
    ssh_public_key = var.ssh_public_key
}

