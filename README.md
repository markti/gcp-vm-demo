# Welcome

This codebase is a sample solution from the book [Mastering Terraform](https://amzn.to/3XNjHhx). This codebase is the solution from Chapter 13 where Soze Enterprises is deploying their solution using Google Cloud Compute Engine. It includes infrastructure as code (IaC) using Terraform and configuration management with Packer. Here is a summary of the key components:

## Packer Code

The Packer code is stored in `src\packer` under directories for each of the two Packer templates. One for the `frontend` and another for the `backend`. These Packer templates ultimately deploy the code stored in `src\dotnet`.

## Terraform Code

The Terraform code is stored in `src\terraform`. There is only one root module and it resides within this directory. There is only the default input variables value file `terraform.tfvars` that is loaded by default.

After you build Virtual Machine Images with Packer you will need to update the input variables `frontend_image_name` and `backend_image_name` to reference the correct version and Packer Resource Group (if changed).

You may need to change the `primary_region` input variable value if you wish to deploy to a different region. The default is `us-central1`.

If you want to provision more than one environment you may need to remove the `environment_name` input variable value and specify an additional environment `tfvar` file.

## GitHub Actions Workflows

### Packer Workflows
There are two GitHub Actions workflows that use Packer to build the Virtual Machine images.

### Terraform Workflows
The directory `.github/workflows/` contains GitHub Actions workflows that implement a CI/CD solution using Packer and Terraform. There are individual workflows for the three Terraform core workflow operations `plan`, `apply`, and `destroy`.

# Pre-Requisites

## Google Cloud Setup

### Shared Projects

In order to build Packer images and make them accessible to multiple projects you need to setup a Google Cloud Project where the Google Cloud Compute Images can be stored. In this project, you should enable Google Cloud Compute API.

In order to save Terraform state you need to create a shared Google Cloud Project that Terraform can use as its backend. In this project you should create a Cloud Storage Bucket.

### IAM Service Accounts

In order for GitHub Actions workflows to execute you need to have an identity that they can use to access Google Cloud. Therefore you need to setup a new Service Account for both the Terraform and Packer workflows.

You'll need to download the credentials in JSON format and set them as Environment Variables in GitHub.

The Service Account for Packer should have it's credentials stored in a GitHub environment Variable `PACKER_CREDENTIALS`.

The Service Account for Terraform should have it's credentials stored in a GitHub environment Variable `GOOGLE_APPLICATION_CREDENTIALS`. Optionally you can create a separate service account to control access to the Terraform State backend. You can either store this identity's credential or the Terraform Service Account's credential in another GitHub environment variable `GOOGLE_BACKEND_CREDENTIALS`.

### IAM Permissions

The Packer Service Account needs to be granted the following project level permissions to the 'Package Images' Project created in the previous step.

- Compute Instance Admin (v1)
- IAP-secured Tunnel User
- Service Account User

The Terraform State Service Account needs to be cranted the following project-level permissions to the 'Terraform State' Project.

- Service Account Token Creator
- Storage Object Admin

The Terraform Service Account needs to be added as a member to the `gcp-organization-admins` group.

### GitHub Configuration

You need to add the following environment variables:

- GCP_ORGANIZATION_ID
- PACKER_PROJECT_ID
- BACKEND_BUCKET_NAME

You need to add the following secrets:

- GOOGLE_APPLICATION_CREDENTIALS
- GOOGLE_BACKEND_CREDENTIALS
- PACKER_CREDENTIALS