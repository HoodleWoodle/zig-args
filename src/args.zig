const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;
const Type = std.builtin.Type;
const process = std.process;
const ArgIterator = process.ArgIterator;
const ArrayList = std.ArrayList;

pub const Argument = struct {
    name: []const u8,
    description: []const u8 = "",
};

pub const Option = struct {
    name: []const u8,
    description: []const u8 = "",
    name_short: ?u8 = null,
    params: []const Argument = &.{},
    count: ?u8 = null,
};

pub const Mutex = []Option;

pub const Group = struct {
    name: []const u8,
    options: []const Option = &.{},
    mutices: []const Mutex = &.{},
};

pub const Command = struct {
    name: []const u8 = "",
    description: []const u8 = "",
    options: []const Option = &.{},
    arguments: []const Argument = &.{},
    mutices: []const Mutex = &.{},
    groups: []const Group = &.{},

    fn assert(comptime command: Command, comptime T: type) void {
        _ = T;
        comptime {
            if (command.name.len == 0) {
                @compileError("command name empty");
            }
            // TODO: IMPL
        }
    }
};

pub const Definition = struct {
    Result: type,
    main: Command,
    commands: []const Command = &.{},

    fn assert(comptime definition: Definition) void {
        comptime {
            Command.assert(definition.main, definition.Result);
            for (definition.commands) |command0| {
                for (definition.commands) |command1| {
                    if (command0 == command1) {
                        continue;
                    }
                    if (!mem.eql(u8, command0.name, command1.name)) {
                        continue;
                    }
                    @compileLog(command0.name);
                    @compileError("command name duplicated");
                }
            }
            for (definition.commands) |command| {
                _ = getFieldByName(definition.Result, command.name);
                Command.assert(command);
            }
        }
    }
};

pub fn usage(comptime definition: Definition) []const u8 {
    Definition.assert(definition);
    return ""; // TODO: IMPL
}

pub fn help(comptime definition: Definition) []const u8 {
    Definition.assert(definition);
    return ""; // TODO: IMPL
}

fn parseCommand(comptime T: type, comptime command: Command, args: [][]const u8) T {
    // TODO: IMPL
    const rst = T{};
    _ = command;
    _ = args;
    //var rst = T{};
    //for (args) |arg| {
    //    inline for (command.options) |option| {
    //        if (option.name_short) |name_short| {
    //            if (arg == name_short) {
    //                @field(rst, option.name) = true;
    //            }
    //        }
    //    }
    //}
    return rst;
}

pub fn parseFromSlice(comptime definition: Definition, args: [][]const u8) !definition.Result {
    Definition.assert(definition);
    var result = parseCommand(definition.Result, definition.main, args);

    const command_name_opt = null; // TODO: select command from args
    if (command_name_opt) |command_name| {
        inline for (definition.commands) |command| {
            if (!mem.eql(u8, command.name, command_name)) {
                continue;
            }
            const field = getFieldByName(definition.Result, command.name);
            const T = @typeInfo(field.type).Optional.child;
            @field(result, field.name) = parseCommand(T, command, args);
            return result;
        }
    }

    return result;
}

pub fn parseFromIterator(comptime definition: Definition, allocator: Allocator, args: *ArgIterator) !definition.Result {
    var buffer = ArrayList([]const u8).init(allocator);
    defer buffer.deinit();
    while (args.next()) |arg| {
        try buffer.append(arg);
    }
    return parseFromSlice(definition, buffer.allocatedSlice());
}

pub fn parse(comptime definition: Definition, allocator: Allocator) !definition.Result {
    var args = try process.argsWithAllocator(allocator);
    defer args.deinit();
    return parseFromIterator(definition, allocator, &args);
}

fn getFieldByName(comptime T: type, comptime name: []const u8) Type.StructField {
    inline for (@typeInfo(T).Struct.fields) |field| {
        if (!mem.eql(u8, field.name, name)) {
            continue;
        }
        return field;
    }

    @compileLog(T, name);
    @compileError("field missing");
}

// TODO: subcommand
// TODO: group
// TODO: mutex
// options
// position-argument

// TODO: usage()
// TODO: parse()
