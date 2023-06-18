

## Imp notes


GKE Cluster autoscaler (vertical) makes these scaling decisions based on the resource requests (rather than actual resource utilization) of Pods running on that node pool's nodes

Prometheus is an open-source monitoring and alerting platform, widely adopted by many companies as a Kubernetes monitoring tool

GKE metrics can show CPU and Memory utilization, by default - so no external tool needed

Chronicle SIEM (Security Information and Event Management) delivers modern threat detection and investigation at unprecedented speed and scale, at a predictable price point.

Spinnaker can be configured to trigger pipelines based on Google Pub/Sub messages. Cloud Build > Pub Sub > Spinnaker

Cloud Build can send msg to the topic `cloud-build` and then pubsub can be used to call webhook - to pass build details to some other system


Monitoring Dashboard --> should be shared with URL so that system knows whom to have access. To grant access, Monitoring Viewer role is needed.

Private Logs -- Data Access audit logs, except BigQuery Data Access audit logs, are the only “private logs”.
    * privateLogViewer gives access for these logs, but Log Viewer doesnt provide.


How to remove PII from logs --> Fluentd filter plugin to exclude what is PII and then send logs to GCS
 

Compare Canary with new deployment of current prod


Incident Commander is to establish communication with the rest of the response team

Spinnaker must use GKE Replica Sets to trigger CD

CSR - doesn't support PR based trigger. It supports only for push of branch / tag

Billing - TCO tool - Total Cost of Operations




&nbsp;
&nbsp;


what goes to _Default and _Required
* Logging
    * _Default
        * Data Access audit logs
        * Policy Denied audit logs

    * _Required
        * Admin Activity audit logs
        * System Event audit logs
        * Access Transparency logs - when Google personal is accessing the data


GitLab to Cloud Build - this trigger works via webhook. Create a webhook in GitLab and add (pub key) of VM, add secret (pvt key) in GCP. Use Build Trigger to connect to GitLab webhook 
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
        * Cloud Build Approver role --> can approve the build
    * Bin Auth with Build as Attestor
    




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



