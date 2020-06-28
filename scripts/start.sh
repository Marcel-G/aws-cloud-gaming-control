terraform refresh

paused_instance_ami=$(terraform output paused_instance_ami 2>/dev/null)

if [ -z "$paused_instance_ami" ]
then
  echo "Configuring a new instance..."

  terraform apply \
    -target=module.aws_cloud_gaming
else
  echo "Starting from paused instance AMI..."

  terraform apply \
    -target=module.aws_cloud_gaming \
    -var "custom_ami=$paused_instance_ami" \
    -var "skip_install=1"
fi
