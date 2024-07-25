# Terraform pipeline implemenation guide

We will be using github action to create a CI and CD pipline for making changes to infrastructure using Terraform and Git.
> Pre-requirement
1. basic knowledge of Terraform and git.
2. knows how to create repo.
3. 
 ### Level 1:

**Scope:** 
1. build single EC2 instance.
2. print IP in output

**How to do it?**
need to createa single tf file.
push it to repo and then
pipeline should take it as trigger to execute it.

**What we learned?**
1. create `main.tf` file.
2. add AWS crediential to github

**How can we make it better?**
1. resource are build before pull request is merged. CI and CD need to be sperate
2. how to added approval part.
3. add linting
4. testing is limited to Validate and fmt, more testing need to be added.
5. use for workspace for dev, stag and prod.


