### Null Resource
- A null resource is a resource that does not have any attributes or methods. It is used to represent a resource that does not exist or is not applicable.
- A null resource is created using the `null` keyword.
- A null resource is not a valid resource and cannot be used in a resource block.

### Imp Points
- If you execute null resource, it will not do anything.
- To see the list of resources
    ```
    terraform state list
    ```
- before or after we modified any text in the null resource, we need to taint the resource to apply the changes.
    ```
    terraform taint <null_resource_name>
    ```
- We can modify the text in the null resource and then apply the changes using the `terraform apply` command.
    ```
    terraform apply
    ```