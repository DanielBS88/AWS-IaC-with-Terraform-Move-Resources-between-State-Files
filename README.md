Me ajude a resolver o problema abaixo, passo a passo. Estou linux e preciso gerar os files em terraform para revolver o problema abaixo. Logo me de os passos de como conectar no meu git respositorio e comitar. Também me explique o código, porque tenho que declarar, criar tal arquivo, para que eu possa aprender corretamente terraform e AWS.

Me gere os arquivos de maneira rapida e eficaz no linux, por exemplo. Usando comandos avançados como Touch ou cat >>, dessa forma eu consigo economizar tempo.

Também me mostre como gerar o arquvio .ignore, para evitar envio de arquivos pesado para o repositorio. Me explique por que isso é uma boa pratica.

AWS IaC with Terraform: Move Resources between State Files
Lab Description
The objective of this lab is to learn how to use the terraform state mv command to move a resource between Terraform states. This process involves updating configurations in both the source and destination to properly reflect the move, ensuring that no resources are recreated or deleted in the cloud infrastructure.

Common Task Requirements
•	Do not define the backend in the configuration; Terraform will use the local backend by default.
•	Avoid the usage of the local-exec provisioner.
•	The use of the prevent_destroy lifecycle attribute is prohibited.
•	Use versions.tf to define the required versions of Terraform and its providers.
•	Define the Terraform required_version as >= 1.5.7.
•	All variables must include valid descriptions and type definitions, and they should only be defined in variables.tf.
•	Resource names provided in tasks should be defined via variables or generated dynamically/concatenated (e.g., in locals using Terraform functions). Avoid hardcoding in resource definitions or using the default property for variables.
•	Configure all non-sensitive input parameter values in terraform.tfvars.
•	Outputs must include valid descriptions and should only be defined in outputs.tf.
•	Ensure TF configuration is clean and correctly formatted. Use the terraform fmt command to rewrite Terraform configuration files into canonical format and style.

Task Resources
•	Terraform state file: Stores the current state of resources managed by Terraform stored in a bucket: cmtr-k5vl9gpq-backend-bucket-1768444909
•	Terraform state mv command: Moves a resource between Terraform state files.
•	First directory with terraform files tf_code_1: tf_code_1
•	Second directory with terraform files tf_code_2: tf_code_2
•	IAM Policy Name: custom_policy

Objectives
Learn about Terraform State Management:
Gain an understanding of the terraform state mv command and how it is used to move resources between Terraform state files.
Resource Move:
•	Create a fork of the repository and configure access rights to enable deployment
•	Initialize remote state with commands:
terraform init -backend-config='bucket=cmtr-k5vl9gpq-backend-bucket-1768444909' -backend-config='key=tf_code_1.tfstate' -backend-config='region=us-east-1'
terraform init -backend-config='bucket=cmtr-k5vl9gpq-backend-bucket-1768444909' -backend-config='key=tf_code_2.tfstate' -backend-config='region=us-east-1'
- After completing your edits, provide a link to your repository with the updated files
- Move the aws_iam_policy AWS iam Policy resource from the tf_code_1.tfstate Terraform state file to the tf_code_2.tfstate Terraform state file using the terraform state mv command.
- Cut the file from the tf_code_1 directory and paste it into the second tf_code_2.


Configuration Updates:
•	Delete the resource configuration from the tf_code_1.tfstate Terraform configuration files.
•	Add the resource configuration to the tf_code_2.tfstate Terraform configuration files.

Validation and Observations:
1.	Run terraform plan on both configurations (tf_code_1.tfstate and tf_code_2.tfstate) to verify no changes are detected.
o	Ensure there is no resource creation or deletion in the cloud infrastructure if the resource has been moved successfully and configurations are updated correctly.
2.	Run the following commands:
o	terraform validate to check the syntax and correctness of the configuration files.
o	terraform fmt to ensure the code follows Terraform formatting standards.

Task Verification
Resource Move Verification:
1.	Confirm that the resource (aws_iam_policy) appears in the tf_code_2.tfstate state file after the move operation.
2.	Ensure the resource is removed from the tf_code_2.tfstate state file.
Cloud Infrastructure Check:
1.	Verify in the AWS Management Console that the aws_iam_policy resource has not been affected (deleted or recreated).
2.	Confirm no changes to the resource in the cloud infrastructure.




Terraform Plan Verification:
1.	Run terraform plan on both configurations (tf_code_1.tfstate and tf_code_2.tfstate) to validate that no changes are detected.
________________________________________
Definition of DONE
•	The resource (aws_iam_policy) is successfully moved from the tf_code_1.tfstate state to the tf_code_2.tfstate state without errors.
•	No changes to resources occurred in the cloud infrastructure (check via AWS Web UI).
•	Configurations are updated to reflect the resource move properly.
•	Terraform files are validated and formatted.
