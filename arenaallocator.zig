const std = @import("std");
const expect = std.testing.expect;

//std.heap.ArenaAllocator takes in a child allocator and allows you to allocate many times and only free once. Here, .deinit() is called on the arena, which frees all memory. Using allocator.free in this example would be a no-op (i.e. does nothing).

test "arena allocator" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    _ = try allocator.alloc(u8, 1);
    _ = try allocator.alloc(u8, 10);
    _ = try allocator.alloc(u8, 100);
}
