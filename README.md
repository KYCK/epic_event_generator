# Epic Event Generator

This is a simple way to generate fake data that makes sense in the context of our apps for comsumption by EpicDB.

Running `gen_event` once with no arguments will generate a single event and publish it to rabbitmq.

## Setup

```bash
git clone git@github.com:KYCK/epic_event_generator.git
cd epic_event_generator
echo ruby-2.1.2 > .ruby-version
echo epic_event_generator > .ruby-gemset
pushd ../
popd
bundle
```

## Usage

```bash
bin/gen_event
```

the `gen_event` executable generates a single `created` event. If you want to generate an entire series (ie created, updated, deleted events), then pass the `-m` option.

```bash
bin/gen_event -m 3 # will generate all three events in a series
```

Other options are available for setting the rabbitmq host, port, exchange, etc. See the [bin/gen_event](bin/gen_event) file for all options.
