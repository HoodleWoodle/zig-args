pub const args = @import("args.zig");

test {
    const std = @import("std");
    std.testing.refAllDeclsRecursive(@This());
    inline for (.{
        @import("tests.zig"),
    }) |source_file| std.testing.refAllDeclsRecursive(source_file);
}
