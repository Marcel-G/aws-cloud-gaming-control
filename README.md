# aws-cloud-gaming-control

Simple scripts to maintain an AMI of your cloud gaming setup. When "pausing" the instance, snapshots will be created from the volumes before destroying them. That means the next time you start there is no need to install everything again. Snapshots are incremental and stored in S3 so they are cheap and efficient. [How incremental snapshots work](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html#how_snapshots_work).

Built on-top of [aws-cloud-gaming](https://github.com/badjware/aws-cloud-gaming) terraform module. Refer to the [docs for more details](https://github.com/badjware/aws-cloud-gaming/blob/master/docs/getting_started.md).

## Getting started

``` bash
# Assuming terraform, bash, curl, and aws credentials are installed

# Set the desired region and create the infra 
echo 'region = "us-east-1"' >terraform.tfvars
terraform init

./scripts/start.sh

# Get the instance ip
terraform output instance_ip

# Get the Administrator password
terraform output instance_password

# Configure the machine and install any games you want

# When you're done, pause the instance
# This will create an AMI that start script will use next time you want to play so you don't have to re-install and configure everything again.
./scripts/pause.sh

# Alternatively you can stop the instance without updating the AMI
./scripts/stop.sh

# Or destroy everything, including the stored "paused" AMI
terraform destroy
```

You can also use terraform workspaces to manage different AMIs.
That means you can destroy them independently from eachother

```
terraform workspace new rocket-league
```
