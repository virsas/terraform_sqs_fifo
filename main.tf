resource "aws_sqs_queue" "deadletter_queue" {
  name                       = "${var.instance.name}_deadletter.fifo"
  fifo_queue                 = true

  kms_master_key_id          = var.instance.kms
  
  message_retention_seconds  = 1209600
}

resource "aws_sqs_queue" "queue" {
  name                       = "${var.instance.name}.fifo"
  fifo_queue                 = true
  max_message_size           = var.instance.message_size

  kms_master_key_id          = var.instance.kms

  message_retention_seconds  = var.instance.retention_time
  visibility_timeout_seconds = var.instance.visibility_time

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter_queue.arn
    maxReceiveCount     = 3
  })
}
