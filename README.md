# remoll-aws

> **Note:** This is currently a work in progress.

This docker image allows the [remoll simulation framework](https://github.com/JeffersonLab/remoll) to easily be used in the AWS cloud environment.

## Usage

This image is designed to be run via AWS Batch. When the container is started, it accepts the name of an s3 bucket to store the output in as well a macro file to run.

```
[-b|--bucket <s3 bucket name>] [macro to run]
```

### TODO

- Allow macros to be located in s3



