# terraform_sqs_fifo

Terraform module to create FIFO sqs queue.

## Dependencies

- KMS <https://github.com/virsas/terraform_kms>

## Terraform example

``` terraform
variable "sqsexample" {
  default = {
    // name of the queue
    name = "sqsexample"
    // how long the message should stay in the queue if not picked up. 60 (1 minute) to 1209600 (14 days).
    retention_time = 345600
    // Timeout after which the message in the queue will be visible again if accessed. 0 to 43200 (12 hours).
    visibility_time = 120
    // The limit of how many bytes a message can contain. From 1024 (1 KiB) to 262144 (256 KiB).
    message_size = 262144
  } 
}

module "sqs_example" {
  source = "git::https://github.com/virsas/terraform_sqs_fifo.git?ref=v1.0.0"
  instance = var.sqsexample
  // id of the kms key created in different module. This key is then used to encrypt the messages.
  kms = module.kms_sqs.id
}
```

## Output

``` terraform
module.sqs_example.id
module.sqs_example.arn
module.sqs_example.url
```
