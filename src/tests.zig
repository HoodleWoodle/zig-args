const std = @import("std");
const args = @import("args.zig");

test "todo" {
    //comptime var def = args.Definition.init(.{ .name = "0", .description = "description" });
    //var mtx = def.addMutex();
    //_ = mtx;
    //mtx.addOption(.{ .name = "1" });
    //mtx.addOption(.{ .name = "2" });
    //
    //var cmd = def.addCommand(.{ .name = "3", .description = "description" });
    //cmd.addArgument(.{ .name = "4" });
    //cmd.addOption(.{ .name = "5" });
    //
    //var grp = def.addGroup(.{ .name = "6" });
    //grp.addOption(.{ .name = "7" });
    //grp.addOption(.{ .name = "8" });
    //
    //const result = args.parse(def, "");

    //try std.testing.expect(result == args.Result.err);

    const def2 = .{
        .name = "0",
        .description = "description",
        .mutices = .{ .{ .name = "1" }, .{ .name = "2" } },
        .commands = .{
            .name = "3",
            .description = "description",
            .options = .{.{ .name = "4" }},
            .arguments = .{.{ .name = "5" }},
        },
        .groups = .{
            .{
                .name = "6",
                .options = .{ .{ .name = "7" }, .{ .name = "8" } },
            },
        },
    };
    _ = def2;
}
