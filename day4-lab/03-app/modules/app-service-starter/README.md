# App Service Module - Build Your Own

Build your own App Service module from scratch to learn application hosting patterns!

## 🎯 Learning Objectives

- Azure App Service architecture and security patterns
- VNet integration for secure applications
- Managed identity integration with Key Vault
- Application configuration and settings management

## 📋 Requirements

Your module should create:
1. **App Service Plan** - Hosting plan for your application
2. **App Service** - Web application with managed identity
3. **VNet Integration** - Secure connection to your network
4. **Application Settings** - Configuration including Key Vault references

**Total: 4 resources**

## 🚀 Getting Started

1. Review `variables.tf` for the expected interface
2. Fill in `main.tf` with your implementation
3. Test with `terraform validate` and `terraform plan`
4. Study the complete module for comparison

## 💡 Key Concepts

- **VNet Integration**: Secure outbound connectivity
- **Managed Identity**: Authenticate to Key Vault without secrets
- **Key Vault References**: Retrieve secrets securely at runtime
- **App Service Plans**: Compute resources for your applications

---

**Ready to build?** Open `main.tf` and start with the App Service Plan!