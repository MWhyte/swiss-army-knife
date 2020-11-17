# Swiss army knife

This image extends from the base: 
[nicolaka/netshoot](https://github.com/nicolaka/netshoot) 
and adds some additional libraries:

- Java 
- Kafka
- Kafkacat
- Postgres

## Building 
```
docker build --tag mwhyte/swiss-army-knife .
```

## Running for testing
```
docker run --rm -it --name test mwhyte/swiss-army-knife
```

## publishing
```
docker push mwhyte/swiss-army-knife
```

Pushed to dockerhub [mwhyte/swiss-army-knife](https://hub.docker.com/repository/docker/mrwhyte/swiss-army-knife) 
