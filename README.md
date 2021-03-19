# README.md
ポートフォリオのECS環境を構築するterraformです。

# ECR
ECRのレポジトリ作成とimage pushは現状手動で行う必要があります。

# terraform

terraform.tfvarsを作成してAWSのアクセスキーとシークレットアクセスキーを記載します。

```
access_key = "xxxx"
secret_key = "xxxx"
```

その後terraformコマンドでAWS環境構築できます
```
# 確認
terraform plan
# 実行
terraform apply
# 環境破棄
terraform destroy
```
