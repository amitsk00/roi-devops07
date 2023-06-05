
## cloud build 

steps
```
    - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'us-central1-docker.pkg.dev/${PROJECT_ID}/my-docker-repo/my-image']
    - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    entrypoint: 'gcloud'
    timeout: 240s
    allowFailure: true
    allowExitCodes: [1]
    args: ['compute', 'instances', 'create-with-container', 'my-vm-name', '--container-image', 'us-central1-docker.pkg.dev/${PROJECT_ID}/my-docker-repo/my-image']
    env:
    - 'CLOUDSDK_COMPUTE_REGION=us-central1'
    - 'CLOUDSDK_COMPUTE_ZONE=us-central1-a'
```

Build-packs
```
    gcloud builds submit --pack builder=BUILDPACK_BUILDER, \
        env=ENVIRONMENT_VARIABLE, \
        image=IMAGE_NAME
```

Community Builders
```
    git clone https://github.com/GoogleCloudPlatform/cloud-builders-community.git
    cd cloud-builders-community/builder-name
    gcloud builds submit .

    steps:
    - name: 'gcr.io/project-id/builder-name'
    args: ['arg1', 'arg2', ...]
```

Variable Substitutions
```
    steps:
    - name: 'ubuntu'
    args: ['echo', 'hello world']
    substitutions:
        _SUB_VALUE: unused
    options:
        substitution_option: 'ALLOW_LOOSE'
```

Dynamic Substitutions (one varibale to have ref to another var)
```
    steps:
    - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', '${_IMAGE_NAME}', '.']
    substitutions:
        _IMAGE_NAME: 'gcr.io/${PROJECT_ID}/test-image'
    options:
        dynamic_substitutions: true
```

scrit tag (cannot specify args or entrypoint in the same step)
```
    steps:
    - name: 'bash'
    script: |
        #!/usr/bin/env bash
        echo "Hello World"
    - name: 'ubuntu'
    script: echo hello
    - name: 'python'
    script: |
        #!/usr/bin/env python
        print('hello from python')
```


Build Volumes
```
    steps:
    - name: 'ubuntu'
    volumes:
    - name: 'vol1'
        path: '/persistent_volume'
    entrypoint: 'bash'
    args:
    - '-c'
    - |
            echo "Hello, world!" > /persistent_volume/file
    - name: 'ubuntu'
    volumes:
    - name: 'vol1'
        path: '/persistent_volume'
    args: ['cat', '/persistent_volume/file']
```


Volumes and passing values between steps
```
    steps:
    - name: 'ubuntu'
    entrypoint: 'bash'
    args:
        - '-c'
        - |
        echo "Hello, world!" > /persistent_volume/file
    volumes:
    - name: 'myvolume'
        path: '/persistent_volume'
    - name: 'ubuntu'
    entrypoint: 'bash'
    args:
        - '-c'
        - |
        cat /persistent_volume/file
    volumes:
    - name: 'myvolume'
        path: '/persistent_volume'
```

Container images
```
    steps:
    - name: 'gcr.io/cloud-builders/docker'
    args: [ 'build', '-t', 'LOCATION-docker.pkg.dev/PROJECT_ID/REPOSITORY/IMAGE_NAME', '.' ]
    images: ['LOCATION-docker.pkg.dev/PROJECT_ID/REPOSITORY/IMAGE_NAME']
```

Run Docker image
```
    gcloud auth configure-docker HOSTNAME-LIST
    docker run LOCATION-docker.pkg.dev/PROJECT_ID/REPOSITORY/IMAGE_NAME
```

Build and Python
```
    steps:
       - name: python
          entrypoint: python
          args: ["-m", "pip", "install", "--upgrade", "pip"]     
       - name: python
          entrypoint: python
          args: ["-m", "pip", "install", "build", "pytest", "Flask", "--user"]
```

non container (python) artifacts
```
    artifacts:
       python_packages:
       - repository: "https://LOCATION-python.pkg.dev/PROJECT-ID/REPOSITORY"
          paths: ["dist/*"]
```

Python requirements
```
twine
keyrings.google-artifactregistry-auth
```
1. Twine : is for uploading packages to Artifact Registry.
2. keyrings.google-artifactregistry-auth : is the Artifact Registry keyring backend that handles authentication with Artifact Registry for pip and Twine.

Java artifacts in Build
```
    artifacts:
    mavenArtifacts:
    - repository: 'https://LOCATION-maven.pkg.dev/project-id/repository-name'
        path: 'app-path'
        artifactId: 'build-artifact'
        groupId: 'group-id'
        version: 'version'
```

Using GCS for logs
```
    artifacts:
    objects:
        location: gs://${_BUCKET_NAME}/
        paths:
        - ${SHORT_SHA}_test_log.xml
```      
and
```
    steps:
    - name: 'gcr.io/cloud-builders/javac'
    args: ['HelloWorld.java']
    artifacts:
    objects:
        location: 'gs://[STORAGE_LOCATION]/'
        paths: ['HelloWorld.java', 'HelloWorld.class', 'cloudbuild.yaml']
```



## secrets and KMS

Build with Secret Manager (secret goes as ENV var and is added on main step with $$)
```
steps:
- name: 'gcr.io/cloud-builders/docker'
  entrypoint: 'bash'
  args: ['-c', 'docker login --username=$$USERNAME --password=$$PASSWORD']
  secretEnv: ['USERNAME', 'PASSWORD']
availableSecrets:
  secretManager:
  - versionName: projects/PROJECT_ID/secrets/DOCKER_PASSWORD_SECRET_NAME/versions/DOCKER_PASSWORD_SECRET_VERSION
    env: 'PASSWORD'
  - versionName: projects/PROJECT_ID/secrets/DOCKER_USERNAME_SECRET_NAME/versions/DOCKER_USERNAME_SECRET_VERSION
    env: 'USERNAME'
```

Docker login with secrets
```
steps:
- name: gcr.io/cloud-builders/gcloud
  entrypoint: 'bash'
  args: [ '-c', "gcloud secrets versions access latest --secret=secret-name --format='get(payload.data)' | tr '_-' '/+' | base64 -d > decrypted-data.txt" ]
- name: gcr.io/cloud-builders/docker
  entrypoint: 'bash'
  args: [ '-c', 'docker login --username=my-user --password-stdin < decrypted-data.txt']
```

Docker login using KMS
```
 steps:
 - name: 'gcr.io/cloud-builders/docker'
   entrypoint: 'bash'
   args: ['-c', 'docker login --username=$$USERNAME --password=$$PASSWORD']
   secretEnv: ['USERNAME', 'PASSWORD']
 - name: 'gcr.io/cloud-builders/docker'
   entrypoint: 'bash'
   args: ['-c', 'docker pull $$USERNAME/IMAGE:TAG']
   secretEnv: ['USERNAME']
 availableSecrets:
   inline:
   - kmsKeyName: projects/PROJECT_ID/locations/global/keyRings/USERNAME_KEYRING_NAME/cryptoKeys/USERNAME_KEY_NAME
     envMap:
       USERNAME: 'ENCRYPTED_USERNAME'
   - kmsKeyName: projects/PROJECT_ID/locations/global/keyRings/PASSWORD_KEYRING_NAME/cryptoKeys/PASSWORD_KEY_NAME
     envMap:
       PASSWORD: 'ENCRYPTED_PASSWORD'
```

```
steps:
- name: gcr.io/cloud-builders/gcloud
  args:
  - kms
  - decrypt
  - "--ciphertext-file=ENCRYPTED_PASSWORD_FILE"
  - "--plaintext-file=PLAINTEXT_PASSWORD_FILE"
  - "--location=global"
  - "--keyring=KEYRING_NAME"
  - "--key=KEY_NAME"
- name: gcr.io/cloud-builders/docker
  entrypoint: bash
  args:
  - "-c"
  - docker login --username=DOCKER_USERNAME --password-stdin < PLAINTEXT_PASSWORD_FILE
```


## Notifiers

BQ Notifier (notifier file below and then using the same in RUN)
```
apiVersion: cloud-build-notifiers/v1
kind: BigQueryNotifier
metadata:
  name: example-bigquery-notifier
spec:
  notification:
    filter: build.build_trigger_id == "123e4567-e89b-12d3-a456-426614174000"
    params:
      buildStatus: ${build.status}
    delivery:
      table: projects/project-id/datasets/dataset-name/tables/table-name
    template:
      type: golang
      uri: gs://example-gcs-bucket/bq.json


 gcloud run deploy service-name \
   --image=us-east1-docker.pkg.dev/gcb-release/cloud-build-notifiers/bigquery:latest \
   --no-allow-unauthenticated \
   --update-env-vars=CONFIG_PATH=config-path,PROJECT_ID=project-id      

```

HTTP Notifier
```
apiVersion: cloud-build-notifiers/v1
kind: HTTPNotifier
metadata:
  name: example-http-notifier
spec:
  notification:
    filter: build.status == Build.Status.SUCCESS
    params: buildStatus: ${build.status}
    delivery:
      # The `http(s)://` protocol prefix is required.
      url: url
    template:
      type: golang
      uri: gs://example-gcs-bucket/http.json
```


## Custom SA for build needs below permissions
1.  Service Account User (roles/iam.serviceAccountUser)
2.  Logs Writer (roles/logging.logWriter) 
3.  Artifact Registry Create-on-push Writer (roles/artifactregistry.createOnPushWriter) 
4.  Storage Admin (roles/storage.admin) 
5.  Storage Object Admin (roles/storage.objectAdmin) 
6.  App Engine Admin / Run Admin / Functions Developer / GKE Developer / Crypto Decryter etc 


Custom SA for Build
```
steps:
- name: 'bash'
  args: ['echo', 'Hello world!']
logsBucket: 'LOGS_BUCKET_LOCATION'
serviceAccount: 'projects/PROJECT_ID/serviceAccounts/SERVICE_ACCOUNT'
options:
  logging: GCS_ONLY
```


## Build performance improvements

### higher CPU VM

```
gcloud builds submit --config=cloudbuild.yaml \
    --machine-type=N1_HIGHCPU_8 .


steps:
- name: 'gcr.io/cloud-builders/docker'
  args: ['build', '-t', 'gcr.io/my-project/image1', '.']
options:
  machineType: 'N1_HIGHCPU_8'    

```

Caching of docker images (default caching time is 6h )
```
steps:
- name: 'gcr.io/cloud-builders/docker'
  entrypoint: 'bash'
  args: ['-c', 'docker pull gcr.io/$PROJECT_ID/[IMAGE_NAME]:latest || exit 0']
- name: 'gcr.io/cloud-builders/docker'
  args: [
            'build',
            '-t', 'gcr.io/$PROJECT_ID/[IMAGE_NAME]:latest',
            '--cache-from', 'gcr.io/$PROJECT_ID/[IMAGE_NAME]:latest',
            '.'
        ]
images: ['gcr.io/$PROJECT_ID/[IMAGE_NAME]:latest']
```

Kaniko cache (default caching time is 2w )
```
steps:
- name: 'gcr.io/kaniko-project/executor:latest'
  args:
  - --destination=${_LOCATION}-docker.pkg.dev/$PROJECT_ID/${_REPOSITORY}/${_IMAGE}
  - --cache=true
  - --cache-ttl=XXh
```


### Best practices for speeding up builds

1. use higher CPU VM
2. Building leaner containers
3. Using Kaniko cache
4. Using a cached Docker image
5. Caching directories with Google Cloud Storage
6. Avoiding the upload of unnecessary files (use .gcloudignore)


