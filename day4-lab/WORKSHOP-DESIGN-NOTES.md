# Data Block Dependencies - Workshop Design Notes

## Current State
The workshop uses data blocks to demonstrate infrastructure references between labs:
- 02-keyvault references network resources from 01-network
- 03-app references resources from 01-network and 02-keyvault  
- 04-data references resources from 01-network and 02-keyvault

## Benefits of Current Design
1. **Educational Value**: Shows real-world pattern of referencing existing infrastructure
2. **Terraform Best Practices**: Demonstrates data sources, a core Terraform concept
3. **Realistic Dependencies**: Mirrors production scenarios where services depend on shared infrastructure

## Workshop Challenges
1. **Sequential Dependencies**: Students must complete labs in order
2. **State Coordination**: Requires careful variable management across labs
3. **Catch-up Difficulty**: Hard to jump in at later labs if earlier ones failed

## Mitigation Strategies (Implemented)
1. **Clear Documentation**: Each lab's README lists prerequisites
2. **Example Configurations**: terraform.tfvars.example files show exact variable mappings
3. **Validation**: All configurations now pass terraform validate
4. **Dependency Mapping**: Comments in example files clearly show which outputs to use

## Alternative Approaches (Not Implemented)
If workshop format requires complete independence:

### Option A: Remove Cross-Lab Dependencies
- Make each lab create its own resource groups
- Remove data block references between labs
- Trade-off: Lose educational value of infrastructure references

### Option B: Hybrid Approach  
- Keep critical dependencies (like backend)
- Make some labs more self-contained
- Trade-off: Inconsistent patterns across labs

### Option C: Separate Environments
- Each lab deploys to different resource groups
- Use naming conventions to avoid conflicts
- Trade-off: More complex cleanup, higher costs

## Recommendation
**Keep current design** with implemented improvements:
- Data blocks teach important Terraform concepts
- Example files make dependencies manageable
- Prerequisites are clearly documented
- Validation issues are fixed

For future workshops, consider providing "catchup" branches or completed state files for each lab to help students who fall behind.