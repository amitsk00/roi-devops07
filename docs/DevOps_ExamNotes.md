

# Imp notes


&nbsp;
&nbsp;



## GKE 

GKE Cluster autoscaler (`vertical`) makes these scaling decisions `based on the resource requests` (rather than actual resource utilization) of Pods running on that node pool's nodes

Prometheus is an open-source monitoring and alerting platform, widely adopted by many companies as a Kubernetes monitoring tool

GKE metrics can show CPU and Memory utilization, by default - so no external tool needed

Chronicle `SIEM` (Security Information and Event Management) delivers modern threat detection and investigation at unprecedented speed and scale, at a predictable price point.


Container Analysis API: is a service that provides vulnerability scanning and metadata storage for software artifacts. The service performs vulnerability scans on built software artifacts, such as the images in Container Registry, then stores the resulting metadata and makes it available for consumption through an API
    * Auto scanning when pushing the iamge
    * Manual scanning when needed
    * scanned every 30 days if image was pulled in 30 days

Binary Auth / Attestation: To secure your software supply chain, you should consider signing your container images with attestations. Runtime environments like Kubernetes Engine can validate the signature and run only the container images that you have signed/attested with Binary Auth.


&nbsp;
&nbsp;



## CI CD

*Spinnaker* can be configured to trigger pipelines based on *Google Pub/Sub* messages. Cloud Build > Pub Sub > Spinnaker

Cloud Build can send msg to the topic `cloud-build` and then pubsub can be used to call webhook - to pass build details to some other system

Compare Canary with new deployment of current prod

Spinnaker must use `GKE Replica Sets` to trigger CD

CSR - doesn't support PR based trigger. It supports only for push of branch / tag

GitLab to Cloud Build - this trigger works via webhook. Create a webhook in GitLab and add (pub key) of VM, add secret (pvt key) in GCP. Use Build Trigger to connect to `GitLab webhook` 
```
     gcloud alpha builds triggers create webhook \
       --name=TRIGGER_NAME \
       --secret=PATH_TO_SECRET \
       --substitutions='' \
       --filter='' \
       --inline-config=PATH_TO_INLINE_BUILD_CONFIG \ # or --repo=PATH_TO_REPO
       --branch=BRANCH_NAME #  or --tag=TAG_NAME
```


Build - 
    * PR with approval --> PR is a trigger and Approval is added on Trigger. Person with Approval access can approve trigger
        * Cloud Build Editor role --> run build and allows to change trigger
        * `Cloud Build Approver` role --> can approve the build
    * Bin Auth with Build as Attestor
    

 

* Running **Jenkins on GKE ** is recommended
    * Using Helm Charts, Jenkinds can b installed on GKE
    * many build executors can be used and they can be launched in seconds
    * GKE can use Global LB and hence acccessing is easier


&nbsp;
&nbsp;



## Logging
firewall log is enabled at Firewall, VPC Flow logs are enabled at Subnet

syslog and Event Viewer needs Log Agent installation

`catch-all` config for OPS - default way to load all most used apps config

Private Logs -- __Data Access audit logs__, except BigQuery Data Access audit logs, are the only “private logs”.
    * privateLogViewer gives access for these logs, but Log Viewer doesnt provide.

How to remove PII from logs --> Fluentd filter plugin to exclude what is PII and then send logs to GCS



&nbsp;
&nbsp;



## Monitoring
Alerts for burn rate exhaustion need to focus on **slow as well as fast burn**

API and Services page - "transparent SLI" - this page can be used to check which APIs are generating errors or latencies

Monitoring Dashboard --> should be shared with URL so that system knows whom to have access. To grant access, Monitoring Viewer role is needed.





&nbsp;
&nbsp;





## SRE 

Incident Commander is to establish communication with the rest of the response team


SLI at LB is best

    https_lb_rule is the metric type and request_count is best SLO (Internal LB has "internal" prefix on these)
    for TCP LB, there are no requests, so we need custom or log based metrics to be created
    External LB has total_latencies and backend_latencies as metrics (Internal LB has /internal prefix )




## Generic
Billing - TCO tool - Total Cost of Operations


## gcloud commands


* dns-info -->  gcloud dns project-info describe PROJECT_ID 

* versioning on artifacts
    * gcloud artifacts versions list --package=my-pkg
    * gcloud artifacts versions delete 1.0.0 --package=my-pkg
    * gcloud artifacts versions delete 1.0.0 --package=my-pkg --delete-tags




&nbsp;
&nbsp;







&nbsp;
&nbsp;










## Check in lab / console

1. check MIG
    1. Region or multi regional
    2. zonal ?

2. GKE
    1. Bin Auth
    2. Workload logging
    3. regional cluster?
    4. multi regional cluster



