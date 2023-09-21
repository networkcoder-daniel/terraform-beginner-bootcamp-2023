# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project will use semantic versioning for its tagging.

[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API change
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distrobutions

This project is built against Ubuntu.
Please consider checking your Linux distribution and change accordingly to distribution needs. 

[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```sh
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Script

While fixing the Terraform CLI gpg deprecation issues we noticed that the bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI. 

This bash script is located here: [./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow us an easier time debug and executes manual Terraform CLI install.
- This will allow better portability for other projects that need to install Terraform CLI.

### Shebang Considerations

A Shebang (pronounced sha-bang) tells a bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommends we use this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distrbutions
- will search the user's PATH for the bash executable

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.

eg. ` source ./bin/install_terraform_cli`

### Linux Permissions Considerations

Linux permissions work as follows:

In order to make our bash script executable we need to change Linux permissions for the file to be executable at the user mode.

```sh
 chmod u+x ./bin/install_terraform_cli
 ```

Alternatively:

 ```sh
 chmod 744 ./bin/install_terraform_cli
 ```

[Chmod](https://en.wikipedia.org/wiki/Chmod)

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

[Gitpod Task](https://www.gitpod.io/docs/configure/workspaces/tasks)

### Working with Env Vars

### env command

We can list out all the Environment Variables (Env Vars) using the `env` command.

We can filter specific env vars using grep eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command 

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env var without writing export, eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo, eg. `echo $HELLO`

### Scoping Env Vars

When you open up new bash terminals in VS Code it will not be aware of env vars that you have set in another window. 

If you want env vars to persist across all future bash terminals that are opened you need to set env vars in your bash profile, eg. `.bash_profile`

#### Persisting Env Vars in Gitpod 


We can persist env vars into Gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces. 

You can also set env vars in `.gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by ruunning the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload returned that looks like this:

```json
{
    "UserId": "AIDA1TTIDTU577WEGVOYR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from IAM User in order to use AWS CLI.

- Create new user
- Create new user group: Admin (with adminstrator access)
- Security credentials
- Create access key


## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/).

- **Providers** is an interface to APIs that will allow you to create resources in Terraform. (Resources in code)
- **Modules** are a way to make large amounts of Terraform code modular, portable and shareable. 

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terraform commands by typing `terraform`


### Terraform Init

At the start of a new Terraform project we will run `terraform init` to download the binaries for the Terraform providers that we will use in the project.

### Terraform Plan

`terraform plan`

This will generate out a changeset about the state of our infrastructure and what will be changed. 

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

### Terraform Apply

`terraform apply` or `terraform apply --auto-approve`

This will run a plan and pass the changeset to be executed by Terraform. Apply should prompt yes or no. If we want to automatically approve use the **--auto-aprove** flag.

### Terraform Destroy

`terraform destroy`

This will destroy resources.

You can also use the auto approve flag to skip the approve process. eg. `terraform destroy auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with the project.

The Terraform Lock File **should be committed** to your Version Control System (VCS), eg. Github.

### Terraform State Files

`terraform.tfstate` contains information about the current state of your infrastructure. 

This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure.

`terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of Terraform providers.

### Terraform Migrate State

[Migrate state](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate)

### Issues with Terraform Cloud and Gitpod Workspace

When attempting to run `terraform login` it will launch in bash a wysiwyg view to generate a token. This does not work as expected in our Gitpod VS Code environment. 

The workaround is to manually generate a toekn in Terraform Cloud 

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```

To open the file in Gitpod VS Code:

```sh
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-TOKEN-HERE"
    }
  }
}
```

