const std = @import("std");
const args = @import("args.zig");

test "tmp" {
    const definition = .{
        .Result = struct {
            opt0: bool = false,
            opt1: bool = false,
        },
        .main = .{
            .name = "test0",
            .options = &.{
                .{ .name = "opt0", .name_short = 'a' },
                .{ .name = "opt1", .name_short = 'b' },
            },
        },
    };
    const options = args.parse(definition, std.testing.allocator);
    std.debug.print("{any}\n", .{options});
}
