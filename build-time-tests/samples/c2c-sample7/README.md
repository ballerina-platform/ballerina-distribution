## Sample7: Multi module Ballerina Project.

- This sample runs two service in two modules.
- The menu related to each module is mounted as a config map   

### How to run:

1. Compile the project. Command to deploy kubernetes artifacts will be printed on build success.
```bash
$> bal build
Compiling source
	fusion/cafe:1.0.0

Running Tests

	cafe.tea
	No tests found

	cafe
	No tests found

Creating bala
	target/bala/fusion-cafe-any-1.0.0.bala

Generating executable

Generating artifacts...

	@kubernetes:Service 			 - complete 1/2
	@kubernetes:Service 			 - complete 2/2
	@kubernetes:ConfigMap 			 - complete 2/2
	@kubernetes:Deployment 			 - complete 1/1
	@kubernetes:HPA 			 - complete 1/1
	@kubernetes:Docker 			 - complete 2/2

	Execute the below command to deploy the Kubernetes artifacts:
	kubectl apply -f /Users/anuruddha/workspace/ballerinax/module-ballerina-c2c/samples/sample7/target/kubernetes/cafe

	Execute the below command to access service via NodePort:
	kubectl expose deployment cafe-deployment --type=NodePort --name=cafe-svc-local

	target/bin/cafe.jar
```

2. cafe.jar, Dockerfile, docker image and kubernetes artifacts will be generated: 
  

3. Verify the docker image is created:
```bash
$> docker images
REPOSITORY                    TAG                                              IMAGE ID       CREATED              SIZE
cafe-repo/menu                1.0.0                                            e39f385fa0e6   About a minute ago   270MB
```


5. Run kubectl command to deploy artifacts (Use the command printed on screen in step 2):
```bash
$> kubectl apply -f target/kubernetes/cafe/
service/cafe-svc created
configmap/cafe-tea-json created
configmap/cafe-coffe-json created
deployment.apps/cafe-deployment created
horizontalpodautoscaler.autoscaling/cafe-hpa created
```

6. Verify kubernetes deployment, service, secrets and ingress is deployed:
```bash
$> kubectl get pods
NAME                                          READY   STATUS    RESTARTS   AGE
cafe-deployment-f9c8cfb96-ws7xf               1/1     Running   0          29s
```

7. Execute the below command to expose service via NodePort:
```bash
$> kubectl expose deployment cafe-deployment --type=NodePort --name=cafe-svc-local
   service/cafe-svc-local exposed
```

8. Execute the below command to find the NodePort to access the service.
```bash
$> kubctl get svc
NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
cafe-svc         ClusterIP   10.103.129.127   <none>        9091/TCP,9090/TCP               82s
cafe-svc-local   NodePort    10.106.19.96     <none>        9091:31918/TCP,9090:31177/TCP   4s
```

9. Access the service using NodePort (Replace the NodePort(31918,31177) with the output of the above command):
```bash
$> curl http://127.0.0.1:31918/tea/menu
{
  "items": [
    {
      "id": "6",
      "name": "Ginger and Honey",
      "price": "150.00"
    },
    {
      "id": "7",
      "name": "Lime Tea",
      "price": "160.00"
    },
    {
      "id": "8",
      "name": "Black Tea",
      "price": "100.00"
    },
    {
      "id": "9",
      "name": "Earl's gray",
      "price": "150.00"
    },
    {
      "id": "10",
      "name": "Ginger & Honey",
      "price": "550.00"
    }
  ]
}
```
```bash
$> curl http://127.0.0.1:31177/coffe/menu
{
  "items": [
    {
      "id": "1",
      "name": "LATTE",
      "price": "250.00"
    },
    {
      "id": "2",
      "name": "Americano",
      "price": "260.00"
    },
    {
      "id": "3",
      "name": "Cappuccino",
      "price": "300.00"
    },
    {
      "id": "4",
      "name": "Espresso",
      "price": "250.00"
    },
    {
      "id": "5",
      "name": "CAFÉ MOCHA",
      "price": "550.00"
    }
  ]
}
```

8. Undeploy sample:
```bash
$> kubectl delete -f ./target/kubernetes/cafe
$> kubectl delete svc cafe-svc-local
$> docker rmi cafe-repo/menu:1.0.0
```
