# Epic Event Generator

This is a simple way to generate fake data for comsumption by EpicDB.

Running `gen_event` once with no arguments will generate a single event and publish it to rabbitmq.

## Setup

You'll need to install and start elasticsearch. You'll also need to provide a mapping for the `events/card` type. Then clone and bundle this repo.

### Install and Start elasticsearch
```bash
brew update
brew install elasticsearch
elasticsearch --config /usr/local/opt/elasticsearch/config/elasticsearch.yml
```

By default, elasticsearch is very good at guessing what types you are sending it. But it treats all strings as something you may want to be able to do full text searches on. This is not something that we need for EpicDB, so we are going to help elasticsearch out and define mappings for different types.

For now the only mapping you'll need is the one for the `card` event type. We can create the `events` index and define a mapping for `cards` in one request. If you are using the Elasticsearch marvel plugin, you can copy the first put statement in [example_requests/example_request.json](example_requests/example_request.json)
Otherwise you can run the following narly command:

```bash
curl -XPUT '127.0.0.1:9200/events' -d '{"settings":{"number_of_shards":1,"number_of_replicas":1},"mappings":{"card":{"properties":{"eventTarget":{"type":"string","index":"not_analyzed"},"eventType":{"type":"string","index":"not_analyzed"},"eventTimestamp":{"type":"date"},"eventTrigger":{"type":"nested","properties":{"type":{"type":"string","index":"not_analyzed"},"uuid":{"type":"string","index":"not_analyzed"}}},"data":{"type":"nested","properties":{"uuid":{"type":"string","index":"not_analyzed"},"expiresOn":{"type":"date"},"firstName":{"type":"string","index":"not_analyzed"},"kind":{"type":"string","index":"not_analyzed"},"lastName":{"type":"string","index":"not_analyzed"},"avatar":{"type":"string","index":"not_analyzed"},"birthdate":{"type":"date"},"status":{"type":"string","index":"not_analyzed"}}}}}}}'
```

### Clone repo and bundle
```bash
git clone git@github.com:KYCK/epic_event_generator.git
echo ruby-2.1.2 > epic_event_generator/.ruby-version
echo epic_event_generator > epic_event_generator/.ruby-gemset
cd epic_event_generator
bundle
```

## Usage

```bash
bin/gen_event
```

If you want to generate more than one event, pass the `-c` options with the number of events you want to publish.

```bash
bin/gen_event -c 10 # will generate 10 events
```

## Command Line Options

|Option                |Short|Long          |
|----------------------|:---:|:------------:|
|RabbitMQ host         |     |--host        |
|RabbitMQ vhost        |     |--vhost       |
|RabbitMQ user         |-u   |--user        |
|RabbitMQ password     |     |--password    |
|RabbitMQ port         |     |--port        |
|Exchange routing key  |-k   |--key         |
|Exchange name         |     |--exchange    |
|Number of events      |-c   |--count       |
|Don't publish (stdout)|     |--no-publish  |
|Use random date       |     |--random-dates|

## TODO:

- [ ] Pull elasticsearch documentation out of this repo and into EpicDB repo.
