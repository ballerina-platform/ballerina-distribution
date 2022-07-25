# Docker

Ballerina supports generating Docker artifacts from code without any additional configuration. This simplifies the experience of developing and deploying Ballerina code in the cloud. Code to Cloud builds the containers and required artifacts by deriving the required values from the code. If you want to override the default values taken by the compiler, you can use a `Cloud.toml` file.
For more information, see [Code to Cloud Deployment](/learn/run-ballerina-programs-in-the-cloud/code-to-cloud-deployment/).

::: code c2c_docker_deployment.bal :::

Before you build the package, you need to override some default values taken by the compiler. To do this, create a filed named `Cloud.toml` in the package directory, and add the content below to it.
For all the supported key value properties, see [Code to Cloud specification](https://github.com/ballerina-platform/ballerina-spec/blob/master/c2c/code-to-cloud-spec.md).

::: code Cloud.toml :::

Execute the `bal build` command to build the Ballerina package. Code to Cloud generates only one container per package.
::: out build_output.out :::

Verify if the Docker image is generated.
::: out docker_images.out :::

Run the generated Docker image.
::: out docker_run.out :::

Invoke the service.
::: out execute_curl.out:::
