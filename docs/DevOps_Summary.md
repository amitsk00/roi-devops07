## Google Cloud Build

* Cloud Build integrates with Cloud Source Repository, Github, and Gitlab and can be used for Continous Integration and Deployments.
* Cloud Build can import source code, execute build to the specifications, and produce artifacts such as Docker containers or Java archives
* Cloud Build can `trigger` builds on source commits in Cloud Source Repositories or other git repositories.
* Cloud Build build config file specifies the instructions to perform, with steps defined to each task like the test, build and deploy.
* Cloud Build step specifies an action to be performed and is run in a Docker container.
* Cloud Build supports custom images as well for the steps
* Cloud Build integrates with Pub/Sub to publish messages on build’s state changes.
* Cloud Build can **trigger the Spinnaker pipeline through Cloud Pub/Sub** notifications.
* Cloud Build should use a Service Account with a **Container Developer role** to perform deployments on GKE
* Cloud Build uses a directory named /workspace as a working directory and the assets produced by one step can be passed to the next one via the persistence of the /workspace directory.


## Binary Authorization and Vulnerability Scanning

* Binary Authorization provides __software supply-chain security__ for container-based applications. It enables you to configure a policy that the service enforces when an attempt is made to deploy a container image on one of the  supported container-based platforms.
* Binary Authorization uses **attestations** to verify that an image was built by a specific build system or continuous integration (CI) pipeline.
* Vulnerability scanning helps scan images for vulnerabilities by Container Analysis.

>  For Security and compliance reasons if the image deployed needs to be trusted, use Binary Authorization


## Google Source Repositories
* Cloud Source Repositories are fully-featured, private Git repositories hosted on Google Cloud.
* Cloud Source Repositories can be used for collaborative, version-controlled development of any app or service

>  If the code needs to be versioned controlled and needs collaboration with multiple members, choose Git related options


## Google Container Registry/Artifact Registry
* Google Artifact Registry supports all types of artifacts as compared to Container Registry which was limited to container images
* Container Registry is not referred to in the exam
* Artifact Registry supports both regional and multi-regional repositories


## Google Cloud Code
* Cloud Code helps **write, debug, and deploy** the cloud-based applications for IntelliJ, VS Code, or in the browser.


## Google Cloud Client Libraries
* Google Cloud Client Libraries provide client libraries and SDKs in various languages for calling Google Cloud APIs.
* If the language is not supported, Cloud Rest APIs can be used.


## Deployment Techniques
* Recreate deployment – fully scale down the existing application version before you scale up the new application version.
* Rolling update – update a subset of running application instances instead of simultaneously updating every application instance
* Blue/Green deployment – (also known as a red/black deployment), you perform two identical deployments of your application
* GKE supports Rolling and Recreate deployments.
* Rolling deployments support maxSurge (new pods would be created) and maxUnavailable (existing pods would be deleted)
* Managed Instance groups support Rolling deployments using the maxSurge (new pods would be created) and maxUnavailable (existing pods would be deleted) configurations


## Testing Strategies
* Canary testing – partially roll out a change and then evaluate its performance against a baseline deployment
* A/B testing – test a hypothesis by using variant implementations. A/B testing is used to make business decisions (not only predictions) based on the results derived from data.


## Spinnaker
* Spinnaker supports Blue/Green rollouts by dynamically enabling and disabling traffic to a particular Kubernetes resource.
* Spinnaker recommends **comparing canary against an equivalent baseline**, deployed at the same time instead of production deployment.


## Cloud Operations Suite
* Cloud Operations Suite provides everything from monitoring, alert, error reporting, metrics, diagnostics, debugging, trace.


## Google Cloud Monitoring or Stackdriver Monitoring
* Cloud Monitoring helps gain visibility into the performance, availability, and health of your applications and infrastructure.
* Cloud Monitoring Agent/Ops Agent helps capture additional metrics like Memory utilization, Disk IOPS, etc.
* Cloud Monitoring supports log exports where the logs can be sunk to Cloud Storage, Pub/Sub, BigQuery, or an external destination like Splunk.
* Cloud Monitoring API supports push or export custom metrics
* Uptime checks help check if the resource responds. It can check the availability of any public service on VM, App Engine, URL, GKE, or AWS Load Balancer.
* Process health checks can be used to check if any process is healthy


## Google Cloud Logging or Stackdriver logging
* Cloud Logging provides real-time log management and analysis
* Cloud Logging allows ingestion of custom log data from any source
* Logs can be exported by configuring log sinks to BigQuery, Cloud Storage, or Pub/Sub.
* Cloud Logging Agent can be installed for logging and capturing application logs.
* Cloud Logging Agent uses fluentd and fluentd filter can be applied to filter, modify logs before being pushed to Cloud Logging.
* VPC Flow Logs helps record network flows sent from and received by VM instances.
* Cloud Logging Log-based metrics can be used to create alerts on logs.

>  If the logs from VM do not appear on Cloud Logging, check if the agent is installed and running and it has proper permissions to write the logs to Cloud Logging.


## Cloud Error Reporting
* counts, analyzes and aggregates the crashes in the running cloud services


## Cloud Profiler
* Cloud Profiler allows for monitoring of system resources like **CPU and memory** on both GCP and on-premises resources.


## Cloud Trace
* is a distributed tracing system that **collects latency data** from the applications and displays it in the Google Cloud Console.


## Cloud Debugger
* is a feature of Google Cloud that lets you inspect the state of a running application in real-time, without stopping or slowing it down
* Debug `Logpoints` allow logging injection into running services without restarting or interfering with the normal function of the service
* Debug `Snapshots` help capture local variables and the call stack at a specific line location in your app’s source code




# Compute Services
* Compute services like Google Compute Engine and Google Kubernetes Engine are lightly covered more from the security aspects


## Google Compute Engine
* Google Compute Engine is the best IaaS option for computing and provides fine-grained control
* Preemptible VMs and their use cases.  use for short term needs
* Committed Usage Discounts – CUD help provide cost benefits for long-term stable (1 or 3 years) and predictable usage.
* Managed Instance Group can help scale VMs as per the demand. It also helps provide auto-healing and high availability with health checks, in case an application fails.


## Google Kubernetes Engine
* GKE can be scaled using
* Cluster AutoScaler to scale the cluster
* Vertical Pod Scaler to scale the pods with increasing resource needs
* Horizontal Pod Autoscaler helps scale Kubernetes workload by automatically increasing or decreasing the number of Pods in response to the workload’s CPU or memory consumption, or in response to custom metrics reported from within Kubernetes or external metrics from sources outside of your cluster.
* Kubernetes Secrets can be used to store secrets (although they are just base64 encoded values)
* Kubernetes supports rolling and recreate deployment strategies.


## Security
* Cloud KMS can be used to store keys to encrypt data in Cloud Storage and other integrated storage
* Cloud Secret Manager can be used to store secrets as well



## Site Reliability Engineering – SRE
* SRE is a DevOps implementation and focuses on increasing reliability and observability, collaboration, and reducing * toil using automation.
* SLOs help specify a target level for the reliability of your service using SLIs which provide actual measurements.
* SLI Types
    * Availability
    * Freshness
    * Latency
    * Quality
* SLOs – Choosing the measurement method
    * Synthetic clients to measure user experience
    * Client-side instrumentation
    * Application and Infrastructure metrics
    * Logs processing
* SLOs help defines **Error Budget** and Error Budget Policy which need to be aligned with all the stakeholders and help plan releases to focus on features vs reliability.
* SRE focuses on Reducing Toil – Identifying repetitive tasks and automating them.
* Production Readiness Review – PRR
    * Applications should be performance tested for volumes before being deployed to production
    * SLOs should not be modified/adjusted to facilitate production deployments. Teams should work to make the applications SLO compliant before they are deployed to production.



## Incident Management and Response
* Priority should be to mitigate the issue, and then investigate and find the root cause. Mitigating would include
* Rollbacking the release causes issues
* Routing traffic to working site to restore user experience
* Incident Live State Document helps track the events and decision making which can be useful for postmortem.
* involves the following roles
    * Incident Commander/Manager
        * Setup a communication channel for all to collaborate
        * Assign and delegate roles. IC would assume any role, if not delegated.
        * Responsible for Incident Live State Document
    * Communications Lead
        * Provide periodic updates to all the stakeholders and customers
    * Operations Lead
        * Responds to the incident and should be the only group modifying the system during an incident.


## Postmortem
* should contain the root cause
* should be Blameless
* should be shared with all for collaboration and feedback
* should be shared with all the shareholders
* should have proper action items to prevent recurrence with an owner and collaborators, if required.


