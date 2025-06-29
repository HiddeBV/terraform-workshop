# Answer Key - Terraform Associate Practice Exam

---

## Domain 1: Understand Infrastructure as Code (IaC) concepts

### Question 1: B) Automated infrastructure provisioning and management
**Explanation**: IaC's primary benefit is automating the provisioning and management of infrastructure through code, making it repeatable and consistent.

### Question 2: B) Differences between actual infrastructure and the desired state
**Explanation**: Infrastructure drift occurs when the actual infrastructure state differs from what's defined in code, often due to manual changes.

### Question 3: A, B, C, E (Version control, Reproducibility, Documentation, Collaboration)
**Explanation**: IaC provides version control, reproducibility, serves as documentation, and enables collaboration. Faster CPU processing is not a direct benefit of IaC.

### Question 4: B) Infrastructure that is replaced rather than modified
**Explanation**: Immutable infrastructure means resources are replaced entirely rather than modified in place, ensuring consistency and predictability.

### Question 5: C) All changes made through code only
**Explanation**: Best practice dictates that all infrastructure changes should be made through code to maintain consistency and avoid drift.

### Question 6: B) Changes made outside of the IaC tool
**Explanation**: Configuration drift occurs when changes are made to infrastructure outside of the IaC system, causing state inconsistencies.

### Question 7: C) Requires manual intervention
**Explanation**: IaC is designed to minimize manual intervention through automation.

### Question 8: C) Focus on desired end state rather than steps
**Explanation**: Declarative approaches focus on describing the desired end state, while imperative approaches focus on the specific steps to achieve it.

### Question 9: B) IaC makes infrastructure management more predictable and auditable
**Explanation**: IaC improves predictability and auditability but doesn't eliminate all infrastructure problems.

---

## Domain 2: Understand Terraform's purpose

### Question 10: B) Infrastructure provisioning tool
**Explanation**: Terraform is primarily an infrastructure provisioning tool, not configuration management or application deployment.

### Question 11: C) HashiCorp
**Explanation**: Terraform was created and is maintained by HashiCorp.

### Question 12: A, B, C, D, E (AWS, Azure, Google Cloud Platform, VMware, Kubernetes)
**Explanation**: Terraform supports all major cloud providers and many on-premises platforms through its provider ecosystem.

### Question 13: A) APIs
**Explanation**: Terraform uses APIs to communicate with cloud providers and other services.

### Question 14: B) A plugin that enables Terraform to work with an API
**Explanation**: Providers are plugins that enable Terraform to interact with various APIs and services.

### Question 15: C) HCL (HashiCorp Configuration Language)
**Explanation**: Terraform uses HCL as its primary configuration language, though JSON is also supported.

### Question 16: B) A repository of Terraform providers and modules
**Explanation**: The Terraform Registry hosts publicly available providers and modules for reuse.

### Question 17: C) Terraform is agentless and cloud-agnostic
**Explanation**: Terraform doesn't require agents on target systems and works with multiple cloud providers.

### Question 18: B) HashiCorp's managed Terraform service
**Explanation**: Terraform Cloud is HashiCorp's SaaS offering for running Terraform remotely.

### Question 19: B) Terraform works with multiple cloud providers
**Explanation**: Cloud-agnostic means Terraform can work with various cloud providers, not being tied to one specific provider.

### Question 20: A) .tf
**Explanation**: The standard extension for Terraform configuration files is .tf.

### Question 21: B) declarative
**Explanation**: Terraform follows a declarative approach where you describe the desired end state.

---

## Domain 3: Understand Terraform basics

### Question 22: B) Initialize a working directory containing Terraform configuration files
**Explanation**: `terraform init` initializes a working directory and downloads required providers and modules.

### Question 23: B) Shows what actions Terraform will take to reach the desired state
**Explanation**: `terraform plan` creates an execution plan showing what changes will be made.

### Question 24: B) terraform apply
**Explanation**: `terraform apply` executes the changes to reach the desired state.

### Question 25: B) A record of the infrastructure Terraform manages
**Explanation**: Terraform state is a record of the real-world infrastructure that Terraform manages.

### Question 26: B) In a local file called terraform.tfstate
**Explanation**: By default, Terraform stores state locally in a file named terraform.tfstate.

### Question 27: B) Terraform loses track of managed resources
**Explanation**: Without the state file, Terraform cannot track which resources it manages.

### Question 28: A, B, C (.tf, .tf.json, .tfvars)
**Explanation**: Valid Terraform files use .tf, .tf.json (for JSON format), and .tfvars (for variable values).

### Question 29: B) A component of infrastructure (VM, network, etc.)
**Explanation**: A resource represents a component of infrastructure like a virtual machine, network, etc.

### Question 30: B) Read-only information from outside Terraform
**Explanation**: Data sources allow Terraform to read information from outside sources without managing them.

### Question 31: B) Remove all resources managed by Terraform
**Explanation**: `terraform destroy` removes all resources managed by the current Terraform configuration.

### Question 32: A) ${}
**Explanation**: Terraform uses ${} syntax for variable interpolation and expressions.

### Question 33: A) module
**Explanation**: A module is a container for multiple resources that are used together.

### Question 34: C) resource_type.name.attribute
**Explanation**: The correct syntax is resource_type.name.attribute (e.g., aws_instance.web.id).

### Question 35: B) Creates explicit resource dependencies
**Explanation**: The depends_on argument creates explicit dependencies between resources.

### Question 36: B) terraform validate
**Explanation**: `terraform validate` checks the syntax and internal consistency of configuration files.

---

## Domain 4: Use the Terraform CLI

### Question 37: B) terraform init
**Explanation**: `terraform init` downloads and installs provider plugins and modules.

### Question 38: A) terraform refresh
**Explanation**: `terraform refresh` updates the state file with the current real-world state.

### Question 39: A) -v
**Explanation**: The -v flag provides verbose output for Terraform operations.

### Question 40: A) terraform apply plan.tfplan
**Explanation**: You apply a saved plan by specifying the plan file name.

### Question 41: A) terraform show
**Explanation**: `terraform show` displays the current state or a saved plan.

### Question 42: B) -target=resource_name
**Explanation**: The -target flag allows you to focus operations on specific resources.

### Question 43: B) terraform fmt
**Explanation**: `terraform fmt` formats Terraform configuration files to canonical format.

### Question 44: A) terraform graph
**Explanation**: `terraform graph` creates a visual graph of the configuration or execution plan.

### Question 45: A) terraform state rm
**Explanation**: `terraform state rm` removes resources from Terraform state without destroying them.

### Question 46: A) terraform import
**Explanation**: `terraform import` brings existing infrastructure under Terraform management.

### Question 47: B) -auto-approve
**Explanation**: The -auto-approve flag skips interactive approval prompts.

### Question 48: A, B, C (terraform state mv, terraform state rm, terraform import)
**Explanation**: These commands can modify the state. `terraform show` and `terraform state list` are read-only.

### Question 49: B) -state=path
**Explanation**: The -state flag specifies a custom path for the state file.

### Question 50: A) terraform state list
**Explanation**: `terraform state list` shows all resources in the Terraform state.

### Question 51: B) terraform plan -out=plan.out
**Explanation**: The -out flag saves a plan to a file for later application.

### Question 52: A) terraform state show resource_name
**Explanation**: `terraform state show` displays detailed information about a specific resource.

### Question 53: B) -var="name=value"
**Explanation**: The -var flag sets variable values from the command line.

### Question 54: A) terraform state mv
**Explanation**: `terraform state mv` moves resources from one state location to another.

### Question 55: B) -var-file=filename
**Explanation**: The -var-file flag specifies a file containing variable values.

---

## Domain 5: Interact with Terraform modules

### Question 56: B) A container for multiple resources used together
**Explanation**: A module is a container for multiple resources that are used together as a logical unit.

### Question 57: D) All of the above
**Explanation**: Modules can be sourced from local filesystem, Git repositories, Terraform Registry, and other sources.

### Question 58: B) source
**Explanation**: The source argument is required when calling a module to specify where it comes from.

### Question 59: A) Through the module block arguments
**Explanation**: Variables are passed to modules through arguments in the module block.

### Question 60: C) terraform init
**Explanation**: After adding a new module, you must run `terraform init` to download the module.

---

## Scoring Summary

**Passing Score**: 42/60 (70%)

### Domain Performance Targets:
- **Domain 1** (9 questions): Target ≥6 correct
- **Domain 2** (12 questions): Target ≥8 correct  
- **Domain 3** (15 questions): Target ≥10 correct
- **Domain 4** (19 questions): Target ≥13 correct
- **Domain 5** (5 questions): Target ≥3 correct

### Study Recommendations by Score:
- **90-100%**: Ready for certification exam
- **80-89%**: Review weak domains, practice hands-on labs
- **70-79%**: Significant study needed in weak areas
- **Below 70%**: Comprehensive review recommended, complete all workshop labs