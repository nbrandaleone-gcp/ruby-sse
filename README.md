# ruby-demo
### Nick Brandaleone - May 2025

[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run)

This Ruby web app demonstrates Server Sent Events (SSE) written in Ruby,
and deployed to Google Cloud Run.

## Using Ruby bundler for a consistent environment
I need to lock the Gemfile using the `bundle` command.
```bash
bundle lock --add-platform x86_64-linux
bundle config set --local without 'test'
```

## Build and Deploy container on Cloud Run
```bash
gcloud run deploy ruby-demo --source=. \
  --allow-unauthenticated
```

## Deploy to Cloud Run from an existing Docker repo
```bash
gcloud run deploy ruby-demo \
  --image=<Google Artifact Registry Docker Repo> \
  --allow-unauthenticated
```

## Clean-up
```bash
gcloud run services delete ruby-demo
```

### Appendix:
- The Cloud Run [button](https://github.com/GoogleCloudPlatform/cloud-run-button#add-the-cloud-run-button-to-your-repos-readme)
