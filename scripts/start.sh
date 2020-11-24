terraform refresh

paused_instance_ami=$(terraform output paused_instance_ami 2>/dev/null)

if [[ "$paused_instance_ami" == "ami-"* ]]
then
  echo "Starting from paused instance AMI ($paused_instance_ami)"

  terraform apply \
    -target=module.aws_cloud_gaming \
    -var "custom_ami=$paused_instance_ami" \
    -var "skip_install=1"
else
  echo "Configuring a new instance..."

  terraform apply \
    -target=module.aws_cloud_gaming
fi
