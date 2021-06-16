
# <https:§§partner.cloudskillsboost.google§focuses§11602>
> <https://partner.cloudskillsboost.google/focuses/11602>
   
## Activate Cloud Shell

![](2022-02-24-16-45-52.png)

```bash
# list active account (user/service)
gcloud auth list

# list project if
gcloud config list project

```

https://cloud.google.com/sdk/gcloud

## Understanding Regions and Zones

resource ive in regions and zones
![](2022-02-24-16-49-15.png)

https://cloud.google.com/compute/docs/regions-zones/

## Task 1: Create a new instance from the Cloud Console

- nav - compute engibe - vm instances - create instance
  params
- name
- region
- zone
- series
- machine types
- boot disk
- firewall

![](2022-02-24-16-51-53.png)

## Task 1. Create a new instance from the Cloud Console

 Navigation menu (Navigation menu icon), click Compute Engine > VM Instances.

![](2022-07-07-23-01-51.png)

## Task 2: Install an NGINX web server

```bash
sudo su -
apt-get update
apt-get install nginx -y
```

check external ip

## Task 3: Create a new instance with gcloud

```bash
# create a new vm instance
gcloud compute instances create gcelab2 --machine-type n1-standard-2 --zone us-central1-f

# help
gcloud compute instances create --help

# ssh
gcloud compute ssh gclebal2 --zone us-central1-f

```
