# Consistent Hash

This example shows how to use the Consistent Hash routing policy to route traffic to different versions of a service based on the value of a request header.

**The problem**: You have two versions of a service running, v1 and v2, and a user is accessing your app but every time they refresh the page they are getting a different version of the app. You want to make sure that the user always gets the same version of the app.

**The solution**: You can use the Consistent Hash routing policy to route traffic to different versions of a service based on the value of a request header. In this example, we will use the `x-user` header to route traffic to different versions of the nginx app.

Run the following to visualize the default traffic behavior:

```sh
URL="http://127.0.0.1:80/"
NUM_REQUESTS=10

for ((i=1; i<=$NUM_REQUESTS; i++)); do
    curl -s $URL | grep -o "<h1>.*</h1>"
done
```

you will notice that sometimes the nginx output contains "Hello from nginx-v1!" and other time "Hello from nginx-v2!". This is because we haven't given a x-user header to the request, so Istio routes requests to all available versions in a round robin fashion.

Now let's provide a `x-user` header to the request and see what happens:

```sh
for ((i=1; i<=$NUM_REQUESTS; i++)); do
    curl -s --header "x-user: gabriel" $URL | grep -o "<h1>.*</h1>"
done
```

This time, you will notice that all requests are routed to the same version of the app. This is because Istio uses the value of the `x-user` header to route traffic to a specific version of the app. You can change the value of the `x-user` header and see that the traffic is routed to a different version of the app.
