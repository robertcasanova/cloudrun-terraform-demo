# CloudRun Service Demo

To run this demo you need to create a project inside GCP and create a Service Account with role Owner that's used by Terraform to provision all the infrastructure.
The SA key must be saved in "credentials/SA.json".

To run the micro-service using your own domain a SSL certificate must be created.
~~You can purchase a domain from Google and use a GCP Managed certificate~~ or use Let's Encrypt like I did for this test. (see https://eff-certbot.readthedocs.io/en/stable/using.html#dns-plugins)


![Architecture](/docs/architecture.jpg "Architecture Diagram")

See [DOC.md](DOC.md) for additional documentation
