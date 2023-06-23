

###

Cloud Trace, a distributed tracing system for Google Cloud, helps you understand how long it takes your application to handle incoming requests from users or other applications, and how long it takes to complete operations like RPC calls performed when handling the requests.

Cloud Trace runs on Linux in the following environments:

* Compute Engine
* Google Kubernetes Engine (GKE)
* App Engine flexible environment
* App Engine standard environment
* Cloud Run
* Non-Google Cloud environments

Trace is made up of spans

Trace wih
* Open Telemetry (python and few other) (recommended)
* Open Census (Go, Java, PHP)
* Cloud Trace agent


How to force a request to be traced :
"X-Cloud-Trace-Context: TRACE_ID/SPAN_ID;o=TRACE_TRUE"

