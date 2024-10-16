# Kubernetes - Hello world

Ballerina supports generating Kubernetes artifacts from code without any additional configuration. This simplifies the experience of developing and deploying Ballerina code in the cloud. Code to Cloud builds the containers and required artifacts by deriving the required values from the code. If you want to override the default values taken by the compiler, you can use a `Cloud.toml` file.
For more information, see [Code to Cloud deployment](/learn/code-to-cloud-deployment/).

::: code kubernetes_hello_world.bal :::

Before you build the package, you need to override some default values taken by the compiler. To do this, create a filed named `Cloud.toml` in the package directory, and add the content below to it.
For all the supported key value properties, see [Code to Cloud Specification](https://github.com/ballerina-platform/ballerina-spec/blob/master/c2c/code-to-cloud-spec.md).

::: code Cloud.toml :::

Execute the `bal build` command to build the Ballerina package. Code to Cloud generates only one container per package.
>**Note:** macOS users with Apple Silicon chips need to set an environment variable named `DOCKER_DEFAULT_PLATFORM` to `linux/amd64`, before building the image. This is because the Ballerina Docker image is not supported on Apple Silicon chips yet. Run `export DOCKER_DEFAULT_PLATFORM=linux/amd64` to set the environment variable.

::: out build_output.out :::

Push the created Docker image to Docker Hub.
::: out docker_push.out :::

Create the deployment using the Kubernetes artifacts.
::: out kubectl_apply.out :::

Verify the Kubernetes pods.
::: out kubectl_pods.out :::

Expose via NodePort to test in the developer environment.
::: out kubectl_expose.out :::

Get the External IP and port of the Kubernetes service.
::: out kubectl_svc.out :::

If the External IP of the `hello-svc-local` service is `<none>`, you need to follow cluster-specific steps to obtain the external IP. If you are using Minikube, you can use the `minikube ip` command to obtain the IP.
::: out minikube_ip.out :::

Access the deployed service via cURL.
::: out execute_curl.out :::
