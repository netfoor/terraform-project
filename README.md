# Terraform Project Best Practices Guide

## Introduction
This guide summarizes key Terraform concepts and best practices learned from implementing the NGINX server deployment project. Use this as a reference for future infrastructure projects.

## Core Terraform Concepts

### Infrastructure as Code (IaC)
- **Definition**: Managing infrastructure through machine-readable configuration files rather than manual processes
- **Benefits**: Consistency, repeatability, version control, and automation

### Key Components
- **Providers**: Plugins that interact with specific infrastructure services (AWS, Azure, GCP)
- **Resources**: Individual infrastructure components (EC2 instances, security groups, etc.)
- **Variables**: Parameters for customizing configurations
- **Outputs**: Return values from infrastructure deployment
- **Modules**: Reusable, encapsulated configuration components
- **State Files**: Records of deployed infrastructure

## Project Checklist

### Project Setup
- [ ] Install Terraform CLI and cloud provider CLI (AWS/Azure/GCP)
- [ ] Set up version control (Git) repository
- [ ] Create initial project structure with separate files
- [ ] Add proper .gitignore for Terraform files

### Code Organization
- [ ] Split configuration into logical files (main.tf, variables.tf, outputs.tf, etc.)
- [ ] Use descriptive naming conventions for all resources
- [ ] Create reusable modules for common patterns
- [ ] Implement proper variable definitions with descriptions and constraints

### Security Best Practices
- [ ] Generate separate SSH keys for different environments
- [ ] Store sensitive data in secure locations (not in Git)
- [ ] Restrict security group rules to necessary ports and IP ranges
- [ ] Implement proper IAM roles and permissions
- [ ] Use remote backend with encryption for state files

### Environment Management
- [ ] Use workspaces or separate configurations for different environments
- [ ] Use variable files for environment-specific values
- [ ] Implement consistent tagging strategy across all resources
- [ ] Isolate state files between environments

### CI/CD Integration
- [ ] Generate and save plans using `terraform plan -out <filename>.tfplan`
- [ ] Implement plan review in pipeline before applying
- [ ] Automate testing of infrastructure with tools like Terratest
- [ ] Set up notifications for plan/apply failures

### State Management
- [ ] Configure remote backend for state files (S3, Terraform Cloud, etc.)
- [ ] Enable state locking to prevent concurrent modifications
- [ ] Implement state backup strategy
- [ ] Document state import/export procedures

## Essential Commands

```bash
# Initialization
terraform init              # Initialize directory, download providers

# Planning
terraform plan              # Preview changes
terraform plan -out=file    # Save execution plan
terraform plan -var-file=env.tfvars  # Use specific variable file

# Applying
terraform apply             # Apply changes with confirmation
terraform apply -auto-approve  # Apply without confirmation prompt
terraform apply file.tfplan    # Apply a saved plan

# State Management
terraform state list        # List resources in state
terraform state show RESOURCE  # Show details of a resource
terraform import RESOURCE_TYPE.NAME ID  # Import existing infrastructure
terraform state rm RESOURCE  # Remove resource from state

# Environments
terraform workspace new ENV_NAME  # Create new workspace
terraform workspace select ENV_NAME  # Switch workspace
terraform workspace list  # List workspaces

# Destruction
terraform destroy         # Destroy all resources with confirmation
```

## Resource Tagging Standards
Always implement these tags for all resources:

```hcl
tags = {
  Name        = "resource-name"
  Environment = "dev|qa|staging|prod"
  Owner       = "email@example.com"
  Team        = "team-name"
  Project     = "project-name"
  ManagedBy   = "terraform"
  CreatedAt   = "YYYY-MM-DD"
}
```

## Module Structure Best Practices
```
module/
├── README.md           # Module documentation
├── main.tf            # Main resource definitions
├── variables.tf       # Input variable definitions
├── outputs.tf         # Output definitions
├── versions.tf        # Required provider versions
└── examples/          # Example implementations
```

## Security Keys Management
Generate environment-specific SSH keys

```bash
ssh-keygen -t rsa -b 2048 -f 'env-name.key'
```

- Add key files to .gitignore
- Consider using a secrets manager (AWS Secrets Manager, HashiCorp Vault)

## Testing and Verification
SSH into instances
```bash
ssh user@ip-address -i path/to/private/key
```

Verify web services
```bash
terraform output server_public_dns
```

## Importing Existing Resources

```bash
# 1. Import the resource
terraform import aws_instance.server-name i-abcd1234

# 2. View the imported resource state
terraform state show aws_instance.server-name

# 3. Define the resource in your configuration
# 4. Adjust your configuration to match the imported state
```

## Remote State Setup

```hcl
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "project/environment/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-locks" # For state locking
  }
}
```

> Remember: Terraform is not just for creating infrastructure, but also for maintaining and evolving it over time with minimal manual intervention.