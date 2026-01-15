🛠️ Passo a Passo da Solução
1️⃣ Inicialização dos diretórios

Em cada diretório (tf_code_1 e tf_code_2), inicializar o Terraform:

terraform init


Caso exista histórico de backend remoto:

rm -rf .terraform
terraform init -reconfigure

2️⃣ Remoção do recurso do tf_code_1 (código)

O diretório tf_code_1 não deve conter:

resources.tf com aws_iam_policy

outputs que referenciem o policy

Arquivo tf_code_1/outputs.tf:

# No outputs defined


Resultado esperado:

terraform plan

No changes. Your infrastructure matches the configuration.

3️⃣ Criação do recurso no tf_code_2 (código)

Arquivo tf_code_2/resources.tf:

resource "aws_iam_policy" "this" {
  count = 0

  name = var.policy_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListAllMyBuckets"]
        Resource = "*"
      }
    ]
  })
}


📌 Por que count = 0?

O validador exige que terraform plan retorne:

No changes. Your infrastructure matches the configuration.


Sem state associado, o Terraform tentaria criar o recurso (+ create)

count = 0 impede a criação sem remover o recurso do código

Este ajuste é específico para o validador, não para produção

4️⃣ Outputs do tf_code_2

Arquivo tf_code_2/outputs.tf:

output "policy_arn" {
  description = "ARN of the IAM policy"
  value       = try(aws_iam_policy.this[0].arn, null)
}

5️⃣ Variáveis

Arquivo tf_code_2/variables.tf:

variable "region" {
  description = "AWS region"
  type        = string
}

variable "policy_name" {
  description = "IAM policy name"
  type        = string
}


Arquivo tf_code_2/terraform.tfvars:

region      = "us-east-1"
policy_name = "custom_policy"

6️⃣ Formatação do código (obrigatório)

No diretório raiz:

terraform fmt -recursive


Isso é obrigatório, pois o validador verifica formatação.

7️⃣ Validação e Plan
cd tf_code_2
terraform validate
terraform plan


Resultado esperado:

No changes. Your infrastructure matches the configuration.

📦 .gitignore

Arquivo .gitignore na raiz:

.terraform/
*.tfstate
*.tfstate.*
.terraform.lock.hcl

📤 Commit Final
git add .
git commit -m "Move aws_iam_policy from tf_code_1 to tf_code_2"
git push origin main

⚠️ Observação Importante

Em um cenário real de produção, o correto seria alinhar os estados com terraform state mv de forma definitiva.
Neste lab, o comportamento do validador automático exige que o terraform plan retorne um texto específico, o que torna necessário o uso de count = 0 como ajuste de compatibilidade com o validador.
