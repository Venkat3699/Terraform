### To get the details logs of each resource provided in the script:

1. for TRACE
- for power shell execute this command:
    ```
    $env:TF_LOG="TRACE"
    $env:TF_LOG_PATH="trace.txt"
    ```

- for bash execute this command:
    ```
    export TF_LOG="TRACE"
    export TF_LOG_PATH="trace.txt"
    ```

2. for DEBUG
- for power shell execute this command:
    ```
    $env:TF_LOG="DEBUG"
    $env:TF_LOG_PATH="debug.txt"
    ```
- for bash execute this command:
    ```
    export TF_LOG="DEBUG"
    export TF_LOG_PATH="debug.txt"
    ```

3. for ERROR
- for power shell execute this command:
    ```
    $env:TF_LOG="ERROR"
    $env:TF_LOG_PATH="error.txt"
    ```
- for bash execute this command:
    ```
    export TF_LOG="ERROR"
    export TF_LOG_PATH="error.txt"
    ```

- After this we can execute our terraform script with the following command:
    ```
    terraform init
    terraform fmt
    terraform validate
    terraform plan
    terraform apply
    terraform destroy
    ```
- To get the logs of the terraform script, we can check the file we specified in the TF_LOG_PATH variable. The logs will be written in that file.