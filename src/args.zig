const std = @import("std");

const Definition = struct {};

pub const Args = struct {};
pub const Result = union(enum) { args: Args, err: []const u8 };

fn assert_def(comptime def: anytype) Definition {
    comptime {
        const ArgsType = @TypeOf(def);
        if (@typeInfo(ArgsType) != .Struct) {
            @compileError("expected struct argument, found " ++ @typeName(ArgsType));
        }

        // TODO: IMPL
    }
}

fn usage(comptime def: anytype) []const u8 {
    comptime {
        assert_def(def);
    }
}

pub fn help(comptime def: anytype) []const u8 {
    comptime {
        assert_def(def);

        return "";
    }
}

pub fn parse(comptime def: anytype, cli_args: anytype) Result {
    comptime {
        assert_def(def);
    }

    // arg[0]
    // <command>
    //
    // options:
    // -k
    // -k=val
    // -k val
    // -k val0 val1 ...
    // --key
    // --key=val
    // --key val
    // --key val0 val1 ...
    //
    // arguments
    // <arg>

    _ = cli_args;
    return Result{ .err = "" };
}
