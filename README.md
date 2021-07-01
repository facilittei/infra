# Infrastructure

## Setup

```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export TF_VAR_public_key=
export TF_VAR_db_username=
export TF_VAR_db_password=
export TF_VAR_work_allowed_ips=
```

```
terraform init
```

## Select workspace

```
terraform workspace select dev
```

## Run the plan

```
terraform plan -var-file=dev.tfvars -out=terraform.tfplan
```

## Apply the plan

```
terraform apply terraform.tfplan
```