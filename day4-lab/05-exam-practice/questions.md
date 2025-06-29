# Terraform Associate Practice Exam - 60 Questions

**Instructions**: Choose the best answer for each question. For multiple select questions, choose ALL correct answers.

---

## Domain 1: Understand Infrastructure as Code (IaC) concepts (Questions 1-9)

### Question 1 (Single Choice)
What is the primary benefit of Infrastructure as Code (IaC)?
- A) Faster server hardware
- B) Automated infrastructure provisioning and management
- C) Lower cloud costs
- D) Better application performance

### Question 2 (Single Choice)
Which of the following best describes "infrastructure drift"?
- A) Moving infrastructure between cloud providers
- B) Differences between actual infrastructure and the desired state
- C) Slow network performance
- D) Hardware failure

### Question 3 (Multiple Select)
Which are benefits of using Infrastructure as Code? (Select all that apply)
- A) Version control
- B) Reproducibility
- C) Documentation
- D) Faster CPU processing
- E) Collaboration

### Question 4 (Single Choice)
What does "immutable infrastructure" mean?
- A) Infrastructure that cannot be deleted
- B) Infrastructure that is replaced rather than modified
- C) Infrastructure that costs money
- D) Infrastructure that runs forever

### Question 5 (Single Choice)
Which approach is considered a best practice for IaC?
- A) Manual changes followed by code updates
- B) Code changes followed by manual verification
- C) All changes made through code only
- D) Mixing manual and automated changes

### Question 6 (Single Choice)
What is "configuration drift"?
- A) Slow network connections
- B) Changes made outside of the IaC tool
- C) Moving between cloud regions
- D) Application bugs

### Question 7 (Single Choice)
Which is NOT a characteristic of Infrastructure as Code?
- A) Declarative syntax
- B) Version controlled
- C) Requires manual intervention
- D) Repeatable deployments

### Question 8 (Single Choice)
What is the main advantage of declarative over imperative infrastructure code?
- A) Faster execution
- B) Lower cost
- C) Focus on desired end state rather than steps
- D) Better security

### Question 9 (Single Choice)
Which statement about IaC is most accurate?
- A) IaC eliminates all infrastructure problems
- B) IaC makes infrastructure management more predictable and auditable
- C) IaC is only useful for large enterprises
- D) IaC requires specialized hardware

---

## Domain 2: Understand Terraform's purpose (Questions 10-21)

### Question 10 (Single Choice)
What type of tool is Terraform?
- A) Configuration management tool
- B) Infrastructure provisioning tool
- C) Application deployment tool
- D) Monitoring tool

### Question 11 (Single Choice)
Which company created Terraform?
- A) Microsoft
- B) Amazon
- C) HashiCorp
- D) Google

### Question 12 (Multiple Select)
Terraform can provision infrastructure on which platforms? (Select all that apply)
- A) AWS
- B) Azure
- C) Google Cloud Platform
- D) VMware
- E) Kubernetes

### Question 13 (Single Choice)
What does Terraform use to interact with different cloud providers?
- A) APIs
- B) SSH connections
- C) FTP
- D) Email

### Question 14 (Single Choice)
What is a Terraform provider?
- A) A cloud service company
- B) A plugin that enables Terraform to work with an API
- C) A person who writes Terraform code
- D) A paid service

### Question 15 (Single Choice)
What language is Terraform configuration written in?
- A) JSON
- B) YAML
- C) HCL (HashiCorp Configuration Language)
- D) XML

### Question 16 (Single Choice)
What is the Terraform Registry?
- A) A database of Terraform installations
- B) A repository of Terraform providers and modules
- C) A certification program
- D) A paid service

### Question 17 (Single Choice)
Which statement about Terraform is true?
- A) Terraform only works with AWS
- B) Terraform requires agents on target machines
- C) Terraform is agentless and cloud-agnostic
- D) Terraform only supports Linux

### Question 18 (Single Choice)
What is Terraform Cloud?
- A) A cloud provider like AWS
- B) HashiCorp's managed Terraform service
- C) A type of server
- D) A programming language

### Question 19 (Single Choice)
What does "cloud-agnostic" mean in the context of Terraform?
- A) Terraform doesn't work with clouds
- B) Terraform works with multiple cloud providers
- C) Terraform is always running in the cloud
- D) Terraform ignores cloud services

### Question 20 (Single Choice)
What is the primary file extension for Terraform configuration files?
- A) .tf
- B) .hcl
- C) .json
- D) .yaml

### Question 21 (Fill in the blank)
Terraform follows a _______ approach, where you describe the desired end state of your infrastructure.
- A) imperative
- B) declarative
- C) procedural
- D) functional

---

## Domain 3: Understand Terraform basics (Questions 22-36)

### Question 22 (Single Choice)
What is the purpose of the terraform init command?
- A) Start the Terraform service
- B) Initialize a working directory containing Terraform configuration files
- C) Install Terraform
- D) Create a new configuration file

### Question 23 (Single Choice)
What does terraform plan do?
- A) Creates infrastructure
- B) Shows what actions Terraform will take to reach the desired state
- C) Deletes infrastructure
- D) Validates syntax only

### Question 24 (Single Choice)
Which command applies the changes shown in a Terraform plan?
- A) terraform run
- B) terraform apply
- C) terraform execute
- D) terraform deploy

### Question 25 (Single Choice)
What is Terraform state?
- A) Whether Terraform is running or stopped
- B) A record of the infrastructure Terraform manages
- C) The configuration files
- D) Error messages

### Question 26 (Single Choice)
Where is Terraform state stored by default?
- A) In the cloud
- B) In a local file called terraform.tfstate
- C) In memory only
- D) In a database

### Question 27 (Single Choice)
What happens if you lose your Terraform state file?
- A) Nothing, Terraform will recreate it
- B) Terraform loses track of managed resources
- C) The infrastructure is automatically deleted
- D) Terraform will still work normally

### Question 28 (Multiple Select)
Which are valid Terraform configuration file extensions? (Select all that apply)
- A) .tf
- B) .tf.json
- C) .tfvars
- D) .hcl
- E) .yaml

### Question 29 (Single Choice)
What is a Terraform resource?
- A) A file containing configuration
- B) A component of infrastructure (VM, network, etc.)
- C) A person who uses Terraform
- D) A cloud provider

### Question 30 (Single Choice)
What is a Terraform data source?
- A) Information used to configure resources
- B) Read-only information from outside Terraform
- C) A type of provider
- D) A storage location

### Question 31 (Single Choice)
What is the purpose of terraform destroy?
- A) Delete Terraform installation
- B) Remove all resources managed by Terraform
- C) Clear the configuration files
- D) Reset the state file

### Question 32 (Single Choice)
Which symbol is used for variable interpolation in Terraform?
- A) ${}
- B) #{}
- C) $()
- D) %{}

### Question 33 (Fill in the blank)
In Terraform, a _______ is a container for multiple resources that are used together.
- A) module
- B) provider
- C) variable
- D) output

### Question 34 (Single Choice)
What is the correct syntax to reference a resource attribute in Terraform?
- A) resource.type.name.attribute
- B) type.resource.name.attribute
- C) resource_type.name.attribute
- D) name.resource_type.attribute

### Question 35 (Single Choice)
What does the depends_on argument do?
- A) Lists required providers
- B) Creates explicit resource dependencies
- C) Defines variable types
- D) Sets resource timeouts

### Question 36 (Single Choice)
Which Terraform command checks configuration syntax?
- A) terraform check
- B) terraform validate
- C) terraform syntax
- D) terraform test

---

## Domain 4: Use the Terraform CLI (Questions 37-55)

### Question 37 (Single Choice)
Which command downloads and installs provider plugins?
- A) terraform install
- B) terraform init
- C) terraform get
- D) terraform download

### Question 38 (Single Choice)
How do you force Terraform to refresh its view of the current state?
- A) terraform refresh
- B) terraform update
- C) terraform sync
- D) terraform reload

### Question 39 (Single Choice)
Which flag allows you to see more detailed output during Terraform operations?
- A) -v
- B) -verbose
- C) -detailed
- D) -debug

### Question 40 (Single Choice)
How do you apply a specific Terraform plan file?
- A) terraform apply plan.tfplan
- B) terraform apply -plan=plan.tfplan
- C) terraform run plan.tfplan
- D) terraform execute plan.tfplan

### Question 41 (Single Choice)
Which command shows the current state?
- A) terraform show
- B) terraform state
- C) terraform status
- D) terraform list

### Question 42 (Single Choice)
How do you target a specific resource for an operation?
- A) -resource=resource_name
- B) -target=resource_name
- C) -only=resource_name
- D) -select=resource_name

### Question 43 (Single Choice)
Which command formats Terraform configuration files?
- A) terraform format
- B) terraform fmt
- C) terraform style
- D) terraform pretty

### Question 44 (Single Choice)
How do you create a visual graph of your Terraform configuration?
- A) terraform graph
- B) terraform diagram
- C) terraform visual
- D) terraform chart

### Question 45 (Single Choice)
Which command removes a resource from Terraform state without destroying it?
- A) terraform state rm
- B) terraform remove
- C) terraform delete
- D) terraform unmanage

### Question 46 (Single Choice)
How do you import existing infrastructure into Terraform?
- A) terraform import
- B) terraform add
- C) terraform include
- D) terraform attach

### Question 47 (Single Choice)
Which flag forces Terraform to skip confirmation prompts?
- A) -yes
- B) -auto-approve
- C) -force
- D) -confirm

### Question 48 (Multiple Select)
Which commands can modify Terraform state? (Select all that apply)
- A) terraform state mv
- B) terraform state rm
- C) terraform import
- D) terraform show
- E) terraform state list

### Question 49 (Single Choice)
How do you specify a custom state file location?
- A) -statefile=path
- B) -state=path
- C) -tfstate=path
- D) -file=path

### Question 50 (Single Choice)
Which command lists all resources in the Terraform state?
- A) terraform state list
- B) terraform list
- C) terraform show resources
- D) terraform resources

### Question 51 (Single Choice)
How do you save a Terraform plan to a file?
- A) terraform plan > plan.out
- B) terraform plan -out=plan.out
- C) terraform plan -save=plan.out
- D) terraform plan -file=plan.out

### Question 52 (Single Choice)
Which command shows detailed information about a specific resource?
- A) terraform state show resource_name
- B) terraform show resource_name
- C) terraform describe resource_name
- D) terraform info resource_name

### Question 53 (Single Choice)
How do you set a variable value via command line?
- A) -variable="name=value"
- B) -var="name=value"
- C) -set="name=value"
- D) -define="name=value"

### Question 54 (Single Choice)
Which command moves a resource from one state location to another?
- A) terraform state mv
- B) terraform move
- C) terraform relocate
- D) terraform transfer

### Question 55 (Single Choice)
How do you specify a variable file?
- A) -varfile=filename
- B) -var-file=filename
- C) -variables=filename
- D) -file=filename

---

## Domain 5: Interact with Terraform modules (Questions 56-60)

### Question 56 (Single Choice)
What is a Terraform module?
- A) A Terraform provider
- B) A container for multiple resources used together
- C) A command-line tool
- D) A cloud service

### Question 57 (Single Choice)
Where can Terraform modules be sourced from?
- A) Local filesystem only
- B) Git repositories only
- C) Terraform Registry only
- D) All of the above

### Question 58 (Single Choice)
Which argument is required when calling a module?
- A) version
- B) source
- C) providers
- D) count

### Question 59 (Single Choice)
How do you pass variables to a module?
- A) Through the module block arguments
- B) Through environment variables only
- C) Through a separate file only
- D) Modules cannot accept variables

### Question 60 (Single Choice)
What command must be run after adding a new module to your configuration?
- A) terraform apply
- B) terraform plan
- C) terraform init
- D) terraform validate

---

**End of Exam**

Total Questions: 60
Recommended Time: 60 minutes