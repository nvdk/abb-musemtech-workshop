# mu-gentsefeesten
An example set up of mu.semte.ch microservices environment for workshops. This project contains a dataset of events, locations, organizers and themes of the gentse feesten.
Documentation on the data can be found [here](data.org).

## Boot up the system

Boot your microservices-enabled system using docker-compose.

    cd /path/to/mu-project
    docker-compose up

You can shut down using `docker-compose stop` and remove everything using `docker-compose rm`.

## Example queries
Your SPARQL endpoint is available at http://localhost:8890/sparql

All events on location x
```
SELECT * WHERE {
  ?event a <http://schema.org/Event> .
  ?event <http://schema.org/name> ?name.
  ?event <http://schema.org/location> ?location.
  filter(?location = <https://gentsefeesten.stad.gent/api/v1/location/f2e7a735-7632-486c-b70d-7e7340bfd340>)
}

```

All events from organizer y
```
SELECT * WHERE {
  ?event a <http://schema.org/Event> .
  ?event <http://schema.org/name> ?name.
  ?event <http://schema.org/organizer> ?organizer.
  filter(?organizer = <https://gentsefeesten.stad.gent/api/v1/organizer/5f8346d1-7844-47aa-8555-8aee0c0e6b4e>)
}
```

All events on a certain day
```
SELECT * WHERE {
  ?sub a <http://schema.org/Event> .
  ?sub <http://schema.org/name> ?name.
  ?sub <http://schema.org/startDate> ?startDate.
  FILTER (?startDate > "2017-07-21T00:00:00"^^xsd:dateTime && ?startDate < "2017-07-22T00:00:00"^^xsd:dateTime )
}
```

Alle locaties en hun adres:
```
SELECT DISTINCT ?name ?straat ?gemeente WHERE {
 ?p a <http://schema.org/Place> .
 ?p <http://schema.org/name> ?name .
 ?p <http://schema.org/address> ?a .
 ?a <http://schema.org/addressLocality> ?gemeente .
 ?a <http://schema.org/streetAddress> ?straat .
}
```

## Adding a new microservice
Setting up your environment is done in three easy steps:  first you configure the running microservices and their names in `docker-compose.yml`, then you configure how requests are dispatched in `config/dispatcher.ex`, and lastly you start everything.

### Hooking things up with docker-compose

Alter the `docker-compose.yml` file so it contains all microservices you need.  The example content should be clear, but you can find more information in the [Docker Compose documentation](https://docs.docker.com/compose/).  Don't remove the `identifier` and `db` container, they are respectively the entry-point and the database of your application.  Don't forget to link the necessary microservices to the dispatcher and the database to the microservices.

### Configure the dispatcher

Next, alter the file `config/dispatcher.ex` based on the example that is there by default.  Dispatch requests to the necessary microservices based on the names you used for the microservice.


## Let's build a data visualisation
Lets build a visualisation of this data, do you have any suggestions?
Some ideas:
- heatmap of event prices in ghent
- does accessibility of events change over time (eg less accessible events in the evening?)
