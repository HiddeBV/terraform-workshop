.PHONY: docs test clean init plan apply destroy

# Generate terraform-docs for all modules
docs:
	@echo "Generating terraform-docs for all modules..."
	@for dir in day4-lab/*/; do \
		if [ -f "$$dir/main.tf" ] || [ -f "$$dir/variables.tf" ] || [ -f "$$dir/outputs.tf" ]; then \
			echo "Generating docs for $$dir"; \
			terraform-docs markdown table --output-file README.md "$$dir"; \
		fi; \
	done

# Run tests for all modules
test:
	@echo "Running tests for all modules..."
	@if [ -d "day4-lab/test" ]; then \
		cd day4-lab/test && go test -v ./...; \
	fi

# Initialize all Terraform modules
init:
	@echo "Initializing all Terraform modules..."
	@for dir in day4-lab/*/; do \
		if [ -f "$$dir/main.tf" ]; then \
			echo "Initializing $$dir"; \
			cd "$$dir" && terraform init && cd ../..; \
		fi; \
	done

# Plan all Terraform modules
plan:
	@echo "Planning all Terraform modules..."
	@for dir in day4-lab/*/; do \
		if [ -f "$$dir/main.tf" ]; then \
			echo "Planning $$dir"; \
			cd "$$dir" && terraform plan && cd ../..; \
		fi; \
	done

# Apply all Terraform modules
apply:
	@echo "Applying all Terraform modules..."
	@for dir in day4-lab/*/; do \
		if [ -f "$$dir/main.tf" ]; then \
			echo "Applying $$dir"; \
			cd "$$dir" && terraform apply -auto-approve && cd ../..; \
		fi; \
	done

# Destroy all Terraform modules (reverse order)
destroy:
	@echo "Destroying all Terraform modules..."
	@for dir in day4-lab/04-data day4-lab/03-app day4-lab/02-keyvault day4-lab/01-network day4-lab/00-backend; do \
		if [ -f "$$dir/main.tf" ]; then \
			echo "Destroying $$dir"; \
			cd "$$dir" && terraform destroy -auto-approve && cd ../..; \
		fi; \
	done

# Clean up temporary files
clean:
	@echo "Cleaning up temporary files..."
	@find day4-lab -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null || true
	@find day4-lab -name "*.tfstate*" -exec rm -f {} + 2>/dev/null || true
	@find day4-lab -name ".terraform.lock.hcl" -exec rm -f {} + 2>/dev/null || true