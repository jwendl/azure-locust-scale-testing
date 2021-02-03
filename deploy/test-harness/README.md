# Setting up the Test Harness

## Description

This is an example of setting up 1 main virtual machine with 10 agent virtual machines.

This essentially puts everything in the same vnet, but sets up egress so that throttling will not be an issue per virtual machine.

## How to Setup

To run this example just modify the ``` values.tfvars ``` file to names that you want your resources to be.

Then run the following commands

``` bash
terraform init
terraofrm plan -out tf.plan -var-file values.tfvars
terraform apply tf.plan
```
