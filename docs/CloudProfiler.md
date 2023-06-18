
### what is it

Cloud Profiler consists of the profiling agent, which collects the data, and a console interface on Google Cloud, which lets you view and analyze the data collected by the agent.

It shows data as Flame Graph

The profile data is retained for 30 days, so you can analyze performance data for periods up to the last 30 days. Profiles can be downloaded for long-term storage.

Continuous profiling refers to profiling the application while it executes in a production environment. This approach alleviates the need to develop accurate predictive load tests and benchmarks for the production environment. Research on continuous profiling has shown it is accurate and cost effective*.

Cloud Profiler is a continuous profiling tool that is designed for applications running on Google Cloud:

* It's a statistical, or sampling, profiler that has low overhead and is suitable for production environments.
* It supports common languages and collects multiple profile types


* CPU time : is the time the CPU spends executing a block of code. The CPU time for a function tells you how long the CPU was busy executing instructions. It doesn't include the time the CPU was waiting or processing instructions for something else.
* Wall-clock time (also called wall time) : is the time it takes to run a block of code. The wall-clock time for a function measures the time elapsed between entering and exiting a function. Wall-clock time includes all wait time, including that for locks and thread synchronization. The wall time for a block of code can never be less than the CPU time.

* Heap usage (also called heap) : is the amount of memory allocated in the program's heap at the instant the profile is collected. Unlike other profile types where data is collected over an interval, this profile type collects the heap usage at a single point in time.
* Heap allocation (also called allocated heap) : is the total amount of memory that was allocated in the program's heap during the interval in which the profile was collected. This value includes any memory that was allocated and has been freed and is no longer in use

## Python

Profile types for Python: (3.6 +)

* CPU time
* Wall time (main thread)

Profiler code
```
import googlecloudprofiler


def main():
    # Profiler initialization. It starts a daemon thread which continuously
    # collects and uploads profiles. Best done as early as possible.
    try:
        googlecloudprofiler.start(
            service='hello-profiler',
            service_version='1.0.1',
            # verbose is the logging level. 0-error, 1-warning, 2-info,
            # 3-debug. It defaults to 0 (error) if not set.
            verbose=3,
            # project_id must be set if not running on GCP.
            # project_id='my-project-id',
        )
    except (ValueError, NotImplementedError) as exc:
        print(exc)  # Handle errors here
```

### Profiler on non-GCP machine

1. create a new SA
2. Add a role "roles/cloudprofiler.agent" to SA
3. Create JSON key for SA
4. copy the key to non-GCP machine and set the file with path to ADC (GOOGLE_APPLICATION_CREDENTIALS)
5. Python code --> googlecloudprofiler.start(..., project_id='GCP_PROJECT_ID')



| Activity |	Required permissions |
| --- | --- |
| Create profiles |	cloudprofiler.profiles.create |
| List profiles | 	cloudprofiler.profiles.list |
| Modify profiles | 	cloudprofiler.profiles.update |



| Role name |	Includes permissions |	Description | 
| --- | --- | --- | 
| roles/cloudprofiler.agent Cloud Profiler Agent | cloudprofiler.profiles.create , cloudprofiler.profiles.update | 	Ability to register and provide profiling data |
| roles/cloudprofiler.user Cloud Profiler User | cloudprofiler.profiles.list
resourcemanager.projects.get
resourcemanager.projects.list
servicemanagement.projectSettings.get | Ability to view and query profiling data | 