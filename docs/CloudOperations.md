

### Notification channels

1. Email
2. Mobile app
3. PagerDuty
4. SMS
5. Slack
6. webhooks
7. Pub/SUb



Monitoring includes:
* System metrics generated by Google Cloud services (GCE etc)
* System and application metrics that the Google Cloud operations suite agents collect
* User-defined metrics that your service writes by using the Cloud Monitoring API or by using a library like OpenCensus
* Log-based metrics, which collect numeric information about the logs written to Cloud Logging


Time series data is stored for 6 weeks


## Logging

what goes to _Default and _Required
* Logging
    * _Default
        * Data Access audit logs
        * Policy Denied audit logs

    * _Required
        * Admin Activity audit logs
        * System Event audit logs
        * Access Transparency logs - when Google personal is accessing the data


Org level sinks  
    Called as Aggregated sink, at folder or Org level (not for project or Bill Acct as they dont have children)
    need to create with CLI, using --org flag
    ```
        gcloud logging sinks create SINK_NAME
        SINK_DESTINATION  --include-children \
        --folder=FOLDER_ID  (OR  --organization=ORGANIZATION_ID )
        --log-filter="LOG_FILTER"    
    ```



## Monitoring
