# Terraform pipeline implemenation guide
We are using this repo as place holder to practice and test based on best practices for Terraform and IaC via  CICD pipeline. Here we will using different CICD tools, integration tools like linting, testing and other analytic tools like drift detection and impact analysis.

- We will be using github action to create a CI/CD pipline for making changes to infrastructure using Terraform and Git.
> Pre-requirement
1. basic knowledge of Terraform and git.
2. knows how to create repo.

# Workflow of pipeline

We want to document each phase of pipeline and what was done in each phase/stage.
1. Pre-source (Develop Code)
2. Source/Code commit (push code into Repo using pull request)
    - branch protection: we used branch ruleset to  get following behaviour
        - No direct push, only via push request.
        - Need 1 approval beofe mergeing code
        - validate all steps are complete/pass before merging code.   
3. Build phase ( static code analysis/linting, unit testing)
    - Static code analysis/linting: we are using **tflint** and Terraform Fmt
6. Test phase ( integration testing, end-2-end testing, security testing)
    - terraform validate
    - terraform plan -output
    - tfsec / checkov
    - need to make it more mature
7. Release phase ( CD part: release to production as application or image )
    - terraform apply -auto-approve
8. Deploy phase( optional)
9. Monitoring ( post-deployment and smoke testing)

# Scope
- [Learning]
    1. How to add AWS creditential in repo for Workflow to run.
    2. how to add Security in pipeline detecting security vulnerability.
- [Ideas]
 - [ ] Sperate CI and CD tasks/jobs.
 - [ ] Add Better ruleset using github
      - [x] request for approval. ( as it is single user have to disable it.)
      - [x] only pull request, not push
      - [x] Require a pull request before merging
 - [ ] Add linting
      - [x] for code
      - [x] for security
      - [x] For testing
      - [ ] For docs and other files.
 - [ ] Adding Unit to End-to-End test cases. [link](https://spacelift.io/blog/terraform-test)
     - [ ] basic testing using tf validation, tf fmt, . (Integration testing)
     - [ ] 
     
 - [ ] Impact Analysis
     - [ ]  add step to save artifact in artifactory (tfplan)  
 - [ ] Drift dectection
 - [ ] Branching
      - [ ] Use for workspace for dev, stag and prod.
 - [ ] Tagging Stratergies
 - [ ] using prebuild conatiner images to improve performance.
     - [ ] create custom conatiner
     - [ ] create lifecycle for same to make sure we have different version avilable.    
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
  
  
