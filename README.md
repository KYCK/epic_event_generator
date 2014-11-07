# Epic Event Generator

This is a simple way to generate fake data that makes sense in the context of our apps for comsumption by EpicDB.

Running `gen_event` once with no arguments will generate a single event and publish it to rabbitmq.

## Setup

```bash
# Clone repo and bundle
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

|Option              |Short|Long       |
|--------------------|:---:|:---------:|
|RabbitMQ host       |     |--host     |
|RabbitMQ vhost      |     |--vhost    |
|RabbitMQ user       |-u   |--user     |
|RabbitMQ password   |     |--password |
|RabbitMQ port       |     |--port     |
|Exchange routing key|-k   |--key      |
|Exchange name       |     |--exchange |
|Number of events    |-c   |--count    |
