const std = @import("std");
const expect = std.testing.expect;
//The std.heap.FixedBufferAllocator is an allocator that allocates memory into a fixed buffer and does not make any heap allocations. This is useful when heap usage is not wanted, for example, when writing a kernel. It may also be considered for performance reasons. It will give you the error OutOfMemory if it has run out of bytes.

test "fixed buffer allocator" {
    var buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);

    try expect(memory.len == 100);
    try expect(@TypeOf(memory) == []u8);
}
