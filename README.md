# Terraform pipeline implemenation guide
- We will be using github action to create a CI/CD pipline for making changes to infrastructure using Terraform and Git.
> Pre-requirement
1. basic knowledge of Terraform and git.
2. knows how to create repo.
# Scope
- [Learning]
    1. we need to add AWS creditential in repo for Workflow to run.
- [Ideas]
 - [ ] Sperate CI and CD tasks/jobs.
 - [ ] Add bettwe ruleset using github
      - [x] request for approval. ( as it is single user have to disable it.)
      - [x] only pull request, not push 
 - [ ] Add linting
      - [x] for code
      - [x] for security
      - [ ] For testing
      - [ ] For docs and other files.
 - [ ] Adding Unit to End-to-End test cases.
 - [ ] Impact Analysis
 - [ ] Drift dectection
 - [ ] Branching
      - [ ] Use for workspace for dev, stag and prod.
 - [ ] Tagging Stratergies   
### Level 1:
## Logs:
**Day1**
- --------------
We  started with basic level to create a single resource using CI/CD.
- create a single main.tf which will be use for:
  1. Build single EC2 instance.
  2. print IP in output
- create a workflow to trigger infrastructure creation
  1. create a folder name ``
  2. make main.yml

**Day2**
- -------------
We worked on adding Linting and better github ruleset to keep it close to production level.
- **Workflow change**
     Here we made change to add linting and validation steps in existings pipeline,We used  following linters:
  1. [TFLint](https://github.com/terraform-linters/tflint)
  2. [tfsec](https://github.com/aquasecurity/tfsec)
  3. [Terraform Validate](https://www.terraform.io/docs/cli/commands/validate.html)
     
  Some other considerations we can consider later:
    1. [terraform-linter](https://github.com/terraform-linter/terraform-linter)
    2. [Infracost](https://github.com/infracost/infracost)
    3. [Pre-commit Terraform Hooks](https://github.com/antonbabenko/pre-commit-terraform)
     Pre-commit hooks are available for various linters and can be used to enforce Terraform linting as part of the pre-commit process.

- **main.tf**
   We made changes to main.tf to add few changes based on failures we saw from above linter.
- **github settings**
  We add ruleset to
   1. Adding approval
   2. Adding dependency for push/merge to be sucessful.
  
  
