# zig-args

This is a library to parse cli arguments with [Zig](https://ziglang.org/) programming language.

## Table Of Content
1. [General](#general)
2. [Definition](#definition)
   1. [Option](#option)
   2. [Group](#group)
   3. [Mutex](#mutual-exclusive-group)
   4. [Argument](#argument)
   5. [Command](#command)
3. [Functions](#functions)
   1. [Args](#args)
   2. [Result](#result)
4. [Examples](#examples)
5. [TODO](#TODO)

### General
The library can be used by creating an anonymous struct ala [```Definition```](#definition) and then using the given set of [```Functions```](#functions) with it (e.g: [```Examples```](#examples)).

*This part and also the following documentation may be a little bit lacklustre (is this the correct word?). But I think most parts are self explanatory or can be simply tested. Maybe I have time in the future - when [Zig](https://ziglang.org/) is more finalized - to write something more complete.*

*Since the library is strongly influenced by the [argparse](https://argparse.readthedocs.io/en/stable/index.html) lua library, you can take a look there. That may help you. Or maybe not...*

### Definition
The definition is the main point to use the **zig-args** library.

It is defined by an ***anonymous struct***.
There can be either ```arguments``` or ```commands``` in a definition.

Name              | Type                                                        | Required
----------------- | :---------------------------------------------------------: |:--------:
```name```        | ```[]const u8```                                            | ✔
```description``` | ```[]const u8```                                            | ✔
```options```     | anonymous tuple of [```Option```](#option)s                 | ✘
```groups```      | anonymous tuple of [```Group```](#group)s                   | ✘
```mutices```     | anonymous tuple of [```Mutex```](#mutual-exclusive-group)s  | ✘
```arguments```   | anonymous tuple of [```Argument```](#positional-argument)s  | ✘
```commands```    | anonymous tuple of [```Command```](#command)s               | ✘

### Option
This is defined by an ***anonymous struct***.

Name              | Type                      | Description                                    | Required  | Default
----------------- | :-----------------------: | ---------------------------------------------- |:--------: | -------
```name```        | ```[]const u8```          |                                                | ✔         |
```description``` | ```[]const u8```          |                                                | ✔         |
```name_short```  | ```?u8```                 | possible values: ```[a-zA-Z]```                | ✘         | ```null```
```args```        | ```anytype```             | anonymous struct of ```type```s                | ✘         | ```.{}```
```default```     | ```?```anonymous struct   | based on ```args```; ```null``` means optional | ✘         | ```null```
```count```       | ```?u8```                 | maximum number of invocations                  | ✘         | ```null```

### Group
A group combines a set of [Options](#option) and [Mutices](#mutual-exclusive-group) under a given name.

This is defined by an ***anonymous struct***.

Name              | Type                                                        | Required
----------------- | :---------------------------------------------------------: |:--------:
```name```        | ```[]const u8```                                            | ✔
```options```     | anonymous tuple of [```Option```](#option)s                 | ✘
```groups```      | anonymous tuple of [```Group```](#group)s                   | ✘

### Mutual exclusive group
From a mutual exclusive group only one [Option](#option) can be picked.

This is defined by an ***anonymous tuple*** of [Options](#option).

### Positional Argument

Name              | Type                      | Description                                    | Required  | Default
----------------- | :-----------------------: | ---------------------------------------------- |:--------: | -------
```name```        | ```[]const u8```          |                                                | ✔         |
```description``` | ```[]const u8```          |                                                | ✔         |
```args```        | ```anytype```             | anonymous struct of ```type```s                | ✘         | ```.{}```
```default```     | ```?```anonymous struct   | based on ```args```; ```null``` means optional | ✘         | ```null```

### Command
This defines a sub-command.

It is defined by an ***anonymous struct***.

Name              | Type                                                        | Required
----------------- | :---------------------------------------------------------: |:--------:
```name```        | ```[]const u8```                                            | ✔
```description``` | ```[]const u8```                                            | ✔
```options```     | anonymous tuple of [```Option```](#option)s                 | ✘
```groups```      | anonymous tuple of [```Group```](#group)s                   | ✘
```mutices```     | anonymous tuple of [```Mutex```](#mutual-exclusive-group)s  | ✘
```arguments```   | anonymous tuple of [```Argument```](#positional-argument)s  | ✘

### Functions
Name                   | Description
---------------------- | -----------
```help(def)```        | returns the **help** string based on [def](#definition)
```parse(def, args)``` | returns a [Result](#result) based on [def](#definition) and parsed from [args](#args)

#### Args
TODO

### Result
TODO

### Examples
TODO give definition (with pretty much all ...) and show result


## TODO

### features

```
- [ ] documentation
- [ ] definition
   - [ ] options
      - [ ] value choices/validation
      - [ ] anytype args
      - [ ] limitable occurence count
   - [ ] default values
   - [ ] groups
   - [ ] mutual exclusive groups
   - [ ] positional arguments
      - [ ] value choices/validation
      - [ ] anytype args
      - [ ] limitable occurence count
   - [ ] default values
   - [ ] commands
- [ ] functions
   - [ ] usage
   - [ ] usage (automatically added and handled)
   - [ ] help
   - [ ] help (automatically added and handled)
   - [ ] parse
- [ ] result
   - [ ] success value (representing command)
   - [ ] error message
   - [ ] typo autocorrection/suggestions
```
