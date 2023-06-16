
## Compare

| DevOps | SRE |
| -----  |---- |
| Reduce Org SIlos	| Share Ownership | 
| Accept failure as normal	| Blamelessness | 
| Implement gradual change	| Reduce cost of failure | 
| Leverage Toooling and Automation	| 	Toil automation | 
| Measure Everything | Measure Toil and Reliability | 


&nbsp;
&nbsp;

### few concepts
`Blameless postmortem`: Detailed documentation of an incident or outage, its root cause, its impact, actions taken to resolve it, and follow-up actions to prevent its recurrence.

`Reliability`:` The number of “good” interactions divided by the number of total interactions. This leaves you with a numerical fraction of real users who experience a service that is available and working.

`Error budget`: The amount of unreliability you are willing to tolerate.

`Service level indicator (SLI)`: A quantifiable measure of the reliability of your service from your users' perspective.

`Service level objective (SLO)`: Sets the target for an SLI over a period of time.



&nbsp;
&nbsp;

  

Change is best when small and frequent.
Design thinking methodology has five phases: empathize, define, ideate, prototype, and test.
Prototyping culture encourages teams to try more ideas, leading to an increase in faster failures and more successes.
Excessive toil is toxic to the SRE role.
By eliminating toil, SREs can focus the majority of their time on work that will either reduce future toil or add service features.
Resistance to change is usually a fear of loss.
Present change as an opportunity, not a threat.
People react to change in many ways, and IT leaders need to understand how to communicate with and support each group.

  
&nbsp;
&nbsp;

### type of biases
1. Affinity bias: Tendency to gravitate toward those who are similar to you, such as with race, gender, socioeconomic background, or education level.
2. Confirmation bias: Tendency to find information, input, or data that supports your preconceived notions.
3. Selective attention bias: Tendency to pay attention to things, ideas, and input from people whom you tend to gravitate toward.
4. Labeling bias: Tendency to form opinions based on how people look, dress, or appear externally.

&nbsp;
&nbsp;
### HOw SLI should be
1. Measure reliability with good service level indicators (SLIs).
2. A good SLI correlates with user experience with your service; that is, a good SLI tells you when users are happy or unhappy.
3. Measure toil by identifying it, selecting an appropriate unit of measure, and tracking the measurements continuously.
4. Monitoring allows you to gain visibility into a system, which is a core requirement for judging service health and diagnosing your service when things go wrong.
5. Goal-setting, transparency, and data-driven decision making are key components of SRE measurement culture.
6. To make truly data-driven decisions, you need to remove any unconscious biases.



&nbsp;
&nbsp;
### How SRE and Dev teams can work together
1. Kitchen Sink/”Everything SRE” team: We recommend this approach for organizations that have few applications and user journeys and where the scope is small enough that only one team is necessary, but a dedicated SRE team is needed in order to implement its practices.
2. Infrastructure team: This type of team focuses on maintaining shared services and components related to infrastructure, versus an SRE team dedicated to working on services related to products, like customer-facing code.
3. Tools team: This type of SRE team tends to focus on building software to help their developer counterparts measure, maintain, and improve system reliability or other aspects of SRE work, such as capacity planning.
4. Product/Application team: This type of SRE team works to improve the reliability of a critical application or business area. We recommend this implementation for organizations that already have a Kitchen Sink, Infrastructure, or Tools-focused SRE team and have a key user-facing application with high reliability needs.
5. Embedded team: This team has SREs embedded with their developer counterparts, usually one per developer team in scope. The work relationship between the embedded SREs and developers tends to be project- or time-bounded and usually very hands-on, where they perform work like changing code and configuration of the services in scope.
6. Consulting team: This implementation is very similar to the embedded implementation, except SRE are usually less hands-on. We recommend staffing one or two part-time consultants before you staff your first SRE team.


&nbsp;
&nbsp;
### Developing a Google SRE Cultures
1. Organizations with high SRE maturity have well-documented and user-centric SLOs, error budgets, blameless postmortem culture, and a low tolerance for toil.
2. Engineers with operations experience and systems administrators with scripting experience are good first SREs to hire.
3. Upskill current team members with necessary SRE skills such as operations and software engineering, monitoring systems, production automation, system architecture, troubleshooting, culture of trust, and incident management.
4. Contact your Account Executive or Account Director to learn how the Google Cloud Professional Services team can support your organization’s adoption of SRE.



&nbsp;
&nbsp;
====================================================
## CLoud Build help
Cloud Build for python with auth - twine & keyrings.google-artifactregistry-auth

Build with SecretManager and KMS


&nbsp;
&nbsp;
=====================================================

### Moonbank project details (expired)

> DevOpsUser7@roimoonbank.com

> ROI2023dev

WhizLabs - https://quizlet.com/563208858/sre-and-devops-engineer-with-google-cloud-flash-cards/


&nbsp;
&nbsp;
=====================================================

&nbsp;
&nbsp;

# Exam preparation points:

&nbsp;
&nbsp;
## process wise


rolling update with partitions


&nbsp;
&nbsp;
# technical 


VM scopes

container analysis

sink.get permission / log.configwriter


&nbsp;
&nbsp;
## Tools


Alert noti channels - webhook



&nbsp;
&nbsp;


* Cloud billing user
    * Billing Account Creator - Create new  billing accounts.
    * Billing Account Administrator - everything
    * Billing Account Costs Manager - Manage budgets and view and export cost information of billing accounts (but not pricing information).
    * Billing Account Viewer - View billing account cost information and transactions.
    * Billing Account User - Link projects to billing accounts.
    * Project Billing Manager - Link/unlink the project to/from a billing account.

&nbsp;
&nbsp;

Cost of Log Ingestion

CSR - pull request based trigger

Log export to pub-sub

what goes to _Default and _Required
* Logging
    * _Default
        * Data Access audit logs
        * Policy Denied audit logs

    * _Required
        * Admin Activity audit logs
        * System Event audit logs
        * Access Transparency logs - when Google personal is accessing the data

GitLab to Cloud Build - seems this is possible


Org level sinks


&nbsp;
&nbsp;



# exam based
* cloud endpoints - for API and for AE, proxy is deployed auto, uses JWT and LMAO.
* pricing - TCO tool - Total Cost of Operations
* Binary authorization linked to COntainer analysis - Each PGP key is associated with an “attestation note” which is stored in the Container Analysis API. Container Analysis can sign the attestation, verifying the integrity and security of the container image.
* intent based capacity planning
    * Increased agility
    * Reduced costs
    * Improved performance
* dns-info -->  gcloud dns project-info describe PROJECT_ID 
* Spinnaker with Replica Sets
* GKE logging - can we opt out?
* kubectl create ns ??
* versioning on artifacts



## Binary Authorization
* Binary Authorization is a service on Google Cloud that provides *software supply-chain security* for container-based applications.
*  It enables you to configure a policy that the service enforces when an attempt is made to deploy a container image on one of the supported container-based platforms.
* Supported with
    * GKE
    * Run
    * Anthos Mesh
    * Anthos clusters
* `Continuous Validation` (CV) is a feature of Binary Authorization that periodically checks container images associated with running Pods for continued policy conformance.
* `Container Analysis` stores trusted metadata that is used in the authorization process.
    * For each attestor you create, you must create one Container Analysis note. 
    * Each attestation is stored as an occurrence of this note.
* Binary Authorization is based on the `Kritis` specification, which is part of the `Grafeas` open source project.
* An *attestation* certifies that a specific image has completed a previous stage
    * ~Build verification~ in which Binary Authorization uses attestations to verify that an image was built by a specific build system or continuous integration (CI) pipeline.
    * ~Vulnerability scanning~ where the CI-built image has also been scanned for vulnerabilities by Container Analysis.
    * ~Manual check~ where a person, for example, a QA representative, manually creates the attestation.

Binary Authorization provides:

* A policy model that lets you describe the constraints under which images can be deployed
* An attestation model that lets you define trusted authorities who can attest or verify that required processes in your environment have completed before deployment
* A deploy-time enforcer that prevents images that violate the policy from being deployed

Policies will have:
* Deployment rules
* List of exempt images

Each Google Cloud project can have exactly one policy.

three evaluation modes:
* Allow all images: allows all images to be deployed.
* Disallow all images: disallows all images from being deployed.
* Require attestations: requires a signer to digitally sign the image digest and create an attestation before deployment. 

Enforcement modes
* Block and Audit Log:
* Dry Run: Audit Log Only:

Exempt images

Allowlist patterns

Binary Authorization supports two types of keys:
* PKIX
* PGP