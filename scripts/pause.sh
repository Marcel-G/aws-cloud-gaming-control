terraform refresh

instance_id=$(terraform output instance_id 2>/dev/null)

if [ -z "$instance_id" ]
then
  echo "No running instance to pause."
else
  terraform apply \
    -target=aws_ami_from_instance.paused_instance_ami \
    -var "running_instance_id=$instance_id" && \
  terraform destroy \
    -target=module.aws_cloud_gaming \
    -force && \
  echo "Pause succesful" || \
  echo "Pause failed"
fi


