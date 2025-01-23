####  Make sure Enable the Versioning in the S3 Bucket before deploying

1. To Check the available workspaces
    ``` 
    terraform workspace list 
    ```

2. To Create the Workspace
    ```
    terraform workspace new dev
    terraform workspace new uat
    terraform workspace new prod
    ```

3. Switch to Dev Workspace 
    ```
    terraform workspace select dev
    ```

4. To Execute the Script
    ```
    terraform init
    terraform fmt
    terraform validate
    terraform plan
    terraform apply --var-file=dev.tfvars
    terraform state list

5. Switch to Dev Workspace 
    ```
    terraform workspace select uat
    ```

6. To Execute the Script
    ```
    terraform plan --var-file=uat.tfvars
    terraform apply --var-file=uat.tfvars
    terraform state list
    ```

7. Switch to Dev Workspace 
    ```
    terraform workspace select prod
    ```

8. To Execute the Script
    ```
    terraform plan --var-file=prod.tfvars
    terraform apply --var-file=prod.tfvars
    terraform state list
    ```

9. To Destroy the infrastructure
    ```
    terraform workspace select dev
    terraform destroy --var-file=dev.tfvars

    terraform workspace select uat
    terraform destroy --var-file=uat.tfvars

    terraform workspace select prod
    terraform destroy --var-file=prod.tfvars
    ```

10. To delete the WorkSpaces
    ```
    terraform workspace delete dev
    terraform workspace delete uat
    terraform workspace delete prod
    ```

