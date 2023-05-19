# CICD-with-Terraform-Ansible-and-Jenkins

Deploy Grafana and Prometheus to EC2 instances using DevOps tools: Terraform, Ansible, and Jenkins.

Stages:
 - Init: initialize Terraform
 - Plan: what will be created by Terraform
 - Validate Apply: asking if we want to apply (only for dev branch)
 - Apply: applying
   - aws_key_pair
   - aws_instance
   - aws_vpc
   - aws_internet_gateway
   - aws_route_table
   - aws_route
   - aws_default_route_table
   - aws_subnet (public and private)
   - aws_route_table_association
   - aws_security_group
   - aws_security_group_rule
 - Inventory: writing ip address of a new instance to the file aws_hosts
 - EC2 wait: waiting while ec2 instance has initialized
 - Validate Ansible: asking if we want to run ansible (only for dev branch)
 - Ansible: running Ansible and installing Grafana and Prometheus
 - Test Grafana and Prometheus: testing that Grafana and Prometheus are working
 - Validate Destroy: asking if we want to destroy everything
 - Destroy: destroying everything

Post: if we have some failure or aborted - destroying everything
