
# Build a docker image with Jenkins on Kubernetes.

## To build an image on Kubernetes there is a need
- ***_[Kaniko](https://github.com/GoogleContainerTools/kaniko)_ on kubernetes***
- ***Terraform [Dockerfile](https://github.com/hashicorp/terraform/blob/main/Dockerfile)***.

# How to create encrypted secret on Kubernetes cluster for Jenkins pipeline.

## ***Used tools***
- ***[age](https://github.com/FiloSottile/age)*** is a secure file encryption tool (can be used another encryption tool: AWS KMS, GCP KMS, Azure Key Vault and PGP).
- ***[sops](https://github.com/mozilla/sops)*** is an editor of encrypted files.

## Step 1.1. Install age and sops.

### **. age**
```bash
AGE_VERSION=$(curl -s "https://api.github.com/repos/FiloSottile/age/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo age.tar.gz "https://github.com/FiloSottile/age/releases/latest/download/age-v${AGE_VERSION}-linux-amd64.tar.gz"
tar xf age.tar.gz
sudo mv age/age /usr/local/bin
sudo mv age/age-keygen /usr/local/bin
rm -rf age.tar.gz
rm -rf age
age -version
```

### . sops
```bash
sudo apt-get install gcc git libffi-dev libssl-dev libyaml-dev make openssl python-dev-is-python3
sudo apt install python3-pip
sudo pip install --upgrade sops
sops -v
```

## Step 1.2. Create age key
```bash
age-keygen > sops-key.txt
chmod 600 sops-key.txt
export SOPS_AGE_RECIPIENTS=<created public key>
export SOPS_AGE_KEY_FILE=<key's current path>
```
##
## Step 2.1. Base64 Encode your docker username and password.
Example: 
```bash
echo -n username:password | base64
```

## Step 2.2. Copy and paste this configuration
```bash
echo "{"auths":{"https://index.docker.io/v1/":{"auth":"<here should be your encrypted username password from step 2.1>"}}}" > secret
```

## Step 2.3. Using secret content
Add the contents of the secret file in ***docker-config-secret.yaml*** file
```bash
apiVersion: v1
data:
  config.json: {"auths":{"https://index.docker.io/v1/":{"auth":"<here should be your encrypted username password from step 2.1>"}}}
kind: Secret
metadata:
  name: docker-config
type: Opaque
```
##

## Step 3.1. Encrypt the secret
```bash
sops --encrypt -i docker-config-secret.yaml
```
For encrypt one or more specific strings: 
`sops --encrypt --encrypted-suffix 'config.json' -i docker-config-secret.yaml`

## Step 3.2. Decrypt the secret
```bash
sops --decrypt -i docker-config-secret.yaml
```
