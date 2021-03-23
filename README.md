# README.md
簡易Golangサービス起動する簡易ECS環境を構築するterraformです。

映画情報サービスのバックエンドインフラ構築用の terraform です。

# 事前準備

## ECR
ECRのレポジトリ作成とimage pushは現状手動で行う必要があります。

本番環境用のDockerfileを以下のようにbuildしてpushしてください。

```
docker build -t movie-info-backend -f Dockerfile.production .
```

### ドメイン設定

お名前ドットコムでドメインを購入する場合は以下の作業が必要になります。

1. お名前ドットコムでドメイン購入
2. route53 でホストゾーン作成
3. 作成された NS レコードの「値/トラフィックのルーティング先」をお名前ドットコムのネームサーバに設定
4. ドメインに対し acm 証明書を発行

### terraform の事前準備

`terraform.tfvars`に必要な変数を設定してください。

`terraform.tfvars`はシェルスクリプトで雛形を作成できるようにしています。

```
bash ./set_tfvars.sh
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

# terraform 操作コマンド

```
# 初期化
terraform init

# 実行前の確認
terraform plan

# 実行
terraform apply

# 構築した環境の破棄
terraform destroy

# lint
# tflintのインストール必要
tflint
```

workspace で development、production などを判別します。

```
# 環境確認
terraform workspace list

# 環境切り替え
terraform workspace new production
terraform env select production
```
