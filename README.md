# Scale Testing with Locust IO

## Getting Started

This example requires knowledge of [Terraform](https://www.terraform.io/). 

- Clone the Repository
- Go to deploy/environment
- Modify values.tfvars
- Run terraform 
    - ``` terraform init ```
    - ``` terraform plan -out tf.plan -var-file values.tfvars ```
    - ``` terraform apply tf.plan ```
- Go to deploy/test-harness
- Modify values.tfvars
- Run terraform 
    - ``` terraform init ```
    - ``` terraform plan -out tf.plan -var-file values.tfvars ```
    - ``` terraform apply tf.plan ```
- Go to src/
- Run ``` ./deploy.sh -f {function-app-name} ```
- Go to test/
- Run ``` ./install-on-vms.sh -u {user-name} -p {test-harness-prefix} -o {test-harness-postfix} -f {function-app-name} -l {location} ```
- Go to the application insights "live metrics" portal and watch requests per second

## Troubleshooting

If something errors out - go to the "main" virtual machine ({prefix}mvm{postfix}) and type ``` screen -r ```
