<<<<<<< HEAD
# Kubernetes - Hello world
=======
# Kubernetes
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae

Ballerina supports generating Kubernetes artifacts from code without any additional configuration. This simplifies the experience of developing and deploying Ballerina code in the cloud. Code to Cloud builds the containers and required artifacts by deriving the required values from the code. If you want to override the default values taken by the compiler, you can use a `Cloud.toml` file.
For more information, see [Code to Cloud deployment](/learn/run-in-the-cloud/code-to-cloud-deployment/).

::: code kubernetes-hello-world.bal :::

Before you build the package, you need to override some default values taken by the compiler. To do this, create a filed named `Cloud.toml` in the package directory, and add the content below to it.
For all the supported key value properties, see [Code to Cloud Specification](https://github.com/ballerina-platform/ballerina-spec/blob/master/c2c/code-to-cloud-spec.md).

::: code Cloud.toml :::

Execute the `bal build` command to build the Ballerina package. Code to Cloud generates only one container per package.
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

<<<<<<< HEAD
Access the deployed service via cURL.
=======
Access the deployed service via CURL.
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae
::: out execute_curl.out :::
