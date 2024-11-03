# ONLY ENABLE REQUIRED APIs
gcloud services enable cloudbuild.googleapis.com
for SERVICE in $(gcloud services list --enabled --project suara-nusa-labs --format="value(config.name)"); do
  gcloud services disable $SERVICE --project suara-nusa-labs
done

# Make repo in build
 gcloud builds connections create github suara-nusa-repository --region=us-central1

 gcloud projects get-iam-policy suara-nusa-labs --format=json | jq -r '.bindings[] | select(.members[] | contains("user:serviceAccount:service-158751523704@gcp-sa-cloudbuild.iam.gserviceaccount.com")) | .role'
