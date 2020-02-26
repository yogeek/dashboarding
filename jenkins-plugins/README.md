# Jenkins Plugins

## Local setup

Build a Jenkins docker image with pre-installed plugins :

```bash
build.sh
```

Launch a local Jenkins instance :

```bash
run.sh
```

Jenkins is available at : http://localhost:8080

Create some new pipelines jobs in the UI.

## Build Monitor plugin

https://plugins.jenkins.io/build-monitor-plugin/

### Setup

To create a new Build Monitor View, click on the "New View" tab, select "Build Monitor View" and select jobs you wish to display on the monitor.
(or set a regexp to filter jobs like `.*Demo.*` to choose all jobs containing `Demo`)
You can have as many Build Monitor Views as you wish - the most popular approach is to have one per team or one per project.
