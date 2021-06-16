
# <https:§§partner.cloudskillsboost.google§focuses§11604>
> <https://partner.cloudskillsboost.google/focuses/11604>

Create and Manage Cloud Resources: Challenge Lab

```

gcloud config set compute/region us-east1
gcloud config set compute/zone us-east1-b

gcloud compute instances create nucleus-jumphost-182  --machine-type  f1-micro  

gcloud container clusters create my-gke

kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:2.0  
kubectl expose deployment hello-server --type=LoadBalancer --port 8080


gcloud compute instances create www1 \
  --image-family debian-9 \
  --image-project debian-cloud \
  --zone us-east1-b \
  --tags network-lb-tag \
  --metadata startup-script="startup.sh"

 gcloud compute instances create www2 \
  --image-family debian-9 \
  --image-project debian-cloud \
  --zone us-east1-b \
  --tags network-lb-tag \
  --metadata startup-script="startup.sh"


  gcloud compute firewall-rules create allow-tcp-rule-568 \
    --target-tags network-lb-tag --allow tcp:80

  gcloud compute http-health-checks create basic-check

  gcloud compute target-pools create www-pool \
    --region us-east1 --http-health-check basic-check


gcloud compute addresses create network-lb-ip-1 \
 --region us-east1

  gcloud compute forwarding-rules create www-rule \
    --region us-east1 \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool


 gcloud compute instance-templates create lb-backend-template \
   --region=us-east1 \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --image-family=debian-9 \
   --image-project=debian-cloud \
   --metadata=startup-script="startup.sh"



 gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=us-east1-b

gcloud compute backend-services add-backend web-backend-service \
    --instance-group=lb-backend-group \
    --instance-group-zone=us-central1-a \
    --global

```