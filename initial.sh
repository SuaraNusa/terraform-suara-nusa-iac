# ONLY ENABLE REQUIRED APIs
gcloud services enable cloudbuild.googleapis.com
for SERVICE in $(gcloud services list --enabled --project suara-nusa-labs --format="value(config.name)"); do
  gcloud services disable $SERVICE --project suara-nusa-labs
done

# Make repo in build
 gcloud builds connections create github suara-nusa-repository --region=us-west1