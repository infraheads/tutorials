# Build a docker image with Jenkins on Kubernetes.

## To build an image on Kubernetes there is a need
- ***_[Kaniko](https://github.com/GoogleContainerTools/kaniko)_ on kubernetes***
- ***Terraform [Dockerfile](https://github.com/hashicorp/terraform/blob/main/Dockerfile)***.

# How to create encrypted secret on Kubernetes cluster for Jenkins pipeline.

## Used tools
- ***[age](https://github.com/FiloSottile/age)*** is a secure file encryption tool (can be used another encryption tool: AWS KMS, GCP KMS, Azure Key Vault and PGP).
- ***[sops](https://github.com/mozilla/sops)*** is an editor of encrypted files.

## Step 1. Install age and sops.

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

## Step 2. Create age key
```bash
age-keygen > sops-key.txt
chmod 600 sops-key.txt
export SOPS_AGE_RECIPIENTS=<created public key>
export SOPS_AGE_KEY_FILE=<key's current path>
```
## Step 3. Encrypt the secret
```bash
sops --encrypt -i secret
```
For encrypt one or more specific strings: 
`sops --encrypt --encrypted-suffix 'auth' -i pod.yaml`

## Step 4. Decrypt the secret
```bash
sops --decrypt -i secret
```
