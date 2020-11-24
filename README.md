# aws-cloud-gaming-control

Simple scripts to maintain an AMI of your cloud gaming setup. When "pausing" the instance, snapshots will be created from the volumes before destroying them. That means the next time you start there is no need to install everything again. Snapshots are incremental and stored in S3 so they are cheap and efficient. [How incremental snapshots work](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html#how_snapshots_work).

Built on-top of [aws-cloud-gaming](https://github.com/badjware/aws-cloud-gaming) terraform module. Refer to the [docs for more details](https://github.com/badjware/aws-cloud-gaming/blob/master/docs/getting_started.md).

## Requirements

* [terraform](https://www.terraform.io/downloads.html)
* [parsec](https://parsecgaming.com/downloads/) - download and make an account
* [aws-cli](https://docs.aws.amazon.com/polly/latest/dg/setup-aws-cli.html) - install and configure credentials
* [RDP client](https://apps.apple.com/us/app/microsoft-remote-desktop/id1295203466?mt=12) - for initial setup

## Getting started

``` bash
# Assuming terraform, bash, curl, and aws credentials are installed

# Set the desired region. You can find the closest data center with https://www.cloudping.info.
# echo 'region = "us-east-1"' >> terraform.tfvars

# Configure desired instance type
echo 'instance_type = "g4dn.xlarge"' >> terraform.tfvars

terraform init

terraform workspace new rocket-league

./scripts/start.sh

# Get the instance ip
terraform output instance_ip

# Get the Administrator password
terraform output instance_password

# Connect with RDP using the details above.
# Wait for the install and log into parsec on the remote machine.
# Disconnect from RDP and connect using parsec.

# When you're done, pause the instance.
# This will create an AMI that start script will use next time you want to play so you don't have to re-install and configure everything again.
./scripts/pause.sh

# Alternatively you can stop the instance without updating the AMI
./scripts/stop.sh

# Or destroy everything, including the stored "paused" AMI
terraform destroy
```

You can also use terraform workspaces to manage different AMIs.
That means you can destroy them independently from each-other

```
terraform workspace new rocket-league
```

## Troubleshooting

- If you encounter **MaxSpotInstanceCountExceeded** error, review your accounts [spot instance limits](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-limits.html#spot-limits-general)
