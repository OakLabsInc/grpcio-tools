# grpcio-tools building utility

This Docker image can be used to compile Python protobuf libraries in
a Dockerfile without having to install grpcio-tools, which takes a
long time to install and is not required by apps at runtime.

You'll need to use `protobuf==3.6.1` or later in your app.

This example shows how you can use it in your app's Dockerfile. By
using multiple `FROM` directives, you'll save space in your app's
Docker image and save lots of build time.

```
# For Python 2 apps
FROM oaklabs/grpcio-tools:python2.7.15-1.15.0 as protos
# For Python 3 apps
FROM oaklabs/grpcio-tools:python3.7.0-1.15.0 as protos

# Copy in your app's .proto files
COPY *.proto /protos/

RUN python -m grpc_tools.protoc --proto_path=/protos/ --python_out=/protos/ --grpc_python_out=/protos/ /protos/*.proto


# Now build your app
FROM ...
...

# Copy over compiled protobuf libraries
COPY --from=protos /protos/ /protos/

ENV PYTHONPATH=/protos/
```
