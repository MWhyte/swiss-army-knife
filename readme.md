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
docker build --tag codenerve/swiss-army-knife .
```

## Running for testing
```
docker run --rm -it --name test codenerve/swiss-army-knife
```

## publishing
```
docker push codenerve/swiss-army-knife
```

Pushed to dockerhub [codenerve/swiss-army-knife](https://hub.docker.com/repository/docker/codenerve/swiss-army-knife) 
