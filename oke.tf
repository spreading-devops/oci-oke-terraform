data "oci_identity_availability_domains" "ads" {
  compartment_id    = var.compartment_id
}

resource "oci_containerengine_cluster" "k8s_cluster" {
	compartment_id = var.compartment_id
	endpoint_config {
		is_public_ip_enabled = "true"
		subnet_id = "${oci_core_subnet.kubernetes_api_endpoint_subnet.id}"
	}
    freeform_tags   = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
	kubernetes_version = "v1.27.2"
	name = "${var.environment}-cluster"
	options {
		admission_controller_options {
			is_pod_security_policy_enabled = "false"
		}
		persistent_volume_config {
			freeform_tags   = {
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
		service_lb_subnet_ids = ["${oci_core_subnet.service_lb_subnet.id}"]
	}
	vcn_id = "${oci_core_vcn.vcn.id}"
}

resource "oci_containerengine_node_pool" "create_node_pool_details0" {
	cluster_id = "${oci_containerengine_cluster.k8s_cluster.id}"
	compartment_id = var.compartment_id
	count = 1
    freeform_tags       = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    initial_node_labels {
        key             = "name"
        value           = "${var.environment}"
    }
	kubernetes_version = "v1.27.2"
	name = "${var.environment}-nodepool-1"
	node_config_details {
        freeform_tags   = {
            "Environment"   = "${var.environment}",
            "CostCenter"    = "${var.cost_center}"
        }
		placement_configs {
			availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
			subnet_id = "${oci_core_subnet.node_subnet.id}"
		}
		placement_configs {
			availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
			subnet_id = "${oci_core_subnet.node_subnet.id}"
		}
		placement_configs {
			availability_domain = data.oci_identity_availability_domains.ads.availability_domains[2].name
			subnet_id = "${oci_core_subnet.node_subnet.id}"
		}
		size = 2
	}
	node_eviction_node_pool_settings {
		eviction_grace_duration = "PT0S"
	}
	node_shape = var.instance_shape
	node_shape_config {
		memory_in_gbs = 12
		ocpus = 2
	}
	node_source_details {
		boot_volume_size_in_gbs = "50"
		image_id = "ocid1.image.oc1.iad.aaaaaaaamwu6pamu2qv33dcmsta5jp77fkmqjg5nb6zhigk3chlmeoqvt3wa"
		source_type = "IMAGE"
	}
	ssh_public_key = var.ssh_public_key
}

resource "oci_containerengine_node_pool" "create_node_pool_details1" {
	cluster_id = "${oci_containerengine_cluster.k8s_cluster.id}"
	compartment_id = var.compartment_id
	count = 0
    freeform_tags       = {
        "Environment"   = "${var.environment}",
        "CostCenter"    = "${var.cost_center}"
    }
    initial_node_labels {
        key             = "name"
        value           = "${var.environment}"
    }
	kubernetes_version = "v1.26.2"
	name = "${var.environment}-nodepool-2"
	node_config_details {
        freeform_tags   = {
            "Environment"   = "${var.environment}",
            "CostCenter"    = "${var.cost_center}"
        }
		placement_configs {
			availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
			subnet_id = "${oci_core_subnet.node_subnet.id}"
		}
		placement_configs {
			availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
			subnet_id = "${oci_core_subnet.node_subnet.id}"
		}
		placement_configs {
			availability_domain = data.oci_identity_availability_domains.ads.availability_domains[2].name
			subnet_id = "${oci_core_subnet.node_subnet.id}"
		}
		size = 2
	}
	node_eviction_node_pool_settings {
		eviction_grace_duration = "PT0S"
	}
	node_shape = var.instance_shape_amd64
	node_shape_config {
		memory_in_gbs = 8
		ocpus = 1
	}
	node_source_details {
		boot_volume_size_in_gbs = "50"
		image_id = "ocid1.image.oc1.iad.aaaaaaaaonjzueglbpuotbgpugf4xtexpgdjutgbny53364tr5zlsaljkeeq"
		source_type = "IMAGE"
	}
	ssh_public_key = var.ssh_public_key
}