cat > ./terraform.tfvars  << EOS
access_key = "`echo $AWS_ACCESS_KEY_ID`"
secret_key = "`echo $AWS_SECRET_ACCESS_KEY`"
db_user = "admin"
db_pass =
EOS
