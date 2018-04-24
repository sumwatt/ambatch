# ambatch

## *amber batch generator*

I wanted to mock stuff up in YAML as I was reading an API spec. Once I had something
mocked up, I didn't want to have to write a series of commands so I spent considerably
more time writing up a parser for a YAML file.

## Installation

You must have `crystal` cli installed prior.

## Usage

The parsed Yaml file is iterated over. On the outside, you have the generator you want to invoke, followed by the `name` containing an array of string values. This is parsed down into strings which are passed to the command line via `system`


Create a Yaml file similar to:

```yaml
Model:
  Post:
    - "title:string"
    - "body:string"
    - "user:reference"
  User:
    - "name:string"
    - "password:string"
  Comment:
    - "title:string"
    - "body:text"
    - "user:reference"
```

Then invoke:

```bash
ambat -f somefilename.yml
```

## Development

## The Other Shit
This was my introduction to Crystal, coming from having done Ruby in the past. So I ran headlong into the type system. The result isn't pretty. But it mostly works for what I wanted it for.

I wanted to use the `YAML.mapping` abilities but ran into a lack of knowledge
about how to map otherwise structured, but unknown data (the keys are not always going to be consistent to map to a given class).

**@todo** I need to write tests which means it needs to be refactored into a better structure that can easily be tested.

Ultimately, I would like to see this refactored or as something built-in for amber so instead of running this, you could just do:

```
amber batch filename.yml
```



There is a better way - I'm just not there yet...


## Contributing

1. Fork it ( https://github.com/[your-github-name]/ambatch/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request



## Contributors

- [[sumwatt]](https://github.com/[sumwatt]) c. olson - creator, maintainer
