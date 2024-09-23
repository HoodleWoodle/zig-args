# zig-args

This is a library to parse cli arguments with [Zig](https://ziglang.org/) programming language.

## Table Of Content
1. [General](#general)
2. [Definition](#definition)
   - [Option](#option)
      - [Option.Param](#optionparam)
   - [Argument](#argument)
   - [Mutex](#mutex)
   - [Group](#group)
   - [Command](#command)
3. [Functions](#functions)
   - [Args](#args)
   - [Result](#result)
4. [Examples](#examples)
5. [TODO](#TODO)

### General
The library can be used by creating an instance of [```Definition```](#definition) and then working with the given set of [```Functions```](#functions) (e.g: [```Examples```](#examples)).

*This part and also the following documentation may be a little bit lacklustre (is this the correct word?). But I think most parts are self explanatory or can be simply explored. Maybe I have time (motivation...) in the future - when [Zig](https://ziglang.org/) is more finalized - to write something more complete.*

*Since the library is strongly influenced by the functionality of the [argparse](https://argparse.readthedocs.io/en/stable/index.html) lua library, you can take a look there. That may help you. Or maybe not...*

### Definition
The definition is the main point of action for using the **zig-args** library.

Name              | Type                                   | Required | Description
------------------|:--------------------------------------:|:--------:|-------------
```Result```      | ```[]const u8```                       | ✔        | ```parse()``` ([Functions](#functions)) will return an instance of ```Result```; structure has to be based on definition - see [Examples](#examples)
```main```        | slice of [```Commands```](#command)    | ✔        |
```commands```    | slice of [```Commands```](#command)    | ✘        |

### Option
Name              | Type                                   | Required | Description
------------------|:--------------------------------------:|:--------:|-------------
```name```        | ```[]const u8```                       | ✔        |
```description``` | ```[]const u8```                       | ✘        |
```name_short```  | ```?u8```                              | ✘        | possible values: ```[0-9a-zA-Z]```
```args```        | slice of [```Arguments```](#argument)  | ✘        |
```count```       | ```?u8```                              | ✘        | maximum number of invocations; ```null``` means infinite

### Argument
The default value and datatype are based on ```Result``` ([Definition](#definition)).

Name              | Type                                   | Required | Description
------------------|:--------------------------------------:|:--------:|-------------
```name```        | ```[]const u8```                       | ✔        |
```description``` | ```[]const u8```                       | ✘        |

### Mutex
From a ***mutual exclusive*** group only one [Option](#option) can be picked.

```pub const Mutex = []Option;```

### Group
A group combines a set of [Options](#option) and [Mutices](#mutex) under a given name.

Name              | Type                                   | Required
------------------|:--------------------------------------:|:--------:
```name```        | ```[]const u8```                       | ✔
```options```     | slice of [```Options```](#option)      | ✘
```mutices```     | slice of [```Mutices```](#mutex)       | ✘

### Command
Name              | Type                                   | Required
------------------|:--------------------------------------:|:--------:
```name```        | ```[]const u8```                       | ✔
```description``` | ```[]const u8```                       | ✘
```options```     | slice of [```Options```](#option)      | ✘
```arguments```   | slice of [```Arguments```](#argument)  | ✘
```mutices```     | slice of [```Mutices```](#mutex)       | ✘
```groups```      | slice of [```Groups```](#group)        | ✘

### Functions
Name              | Description
------------------|-------------
```usage()```     | returns the **usage** string
```help()```      | returns the **help** string
```parse()```     | returns a ```Result``` ([Definition](#definition)) instance parsed from **args**























### Examples
TODO: at least one for main and one for subcommands
```
const Options = struct {
   opt0: bool,
   opt1: bool,
};
const def = .{
   .Result = Options,
   .name = "exec",
   .options = &.{
      .{ .name = "opt0", .name_short = '0' },
      .{ .name = "opt1", .name_short = '1' },
   },
};
const options = args.parse(def, &[_]u8{ 'a', '4', 'b' });
std.debug.print("{any}\n", .{options});
```


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
