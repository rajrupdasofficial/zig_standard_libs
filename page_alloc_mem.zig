const std = @import("std");
const expect = std.testing.expect;

//The most basic allocator is std.heap.page_allocator. Whenever this allocator makes an allocation, it will ask your OS for entire pages of memory; an allocation of a single byte will likely reserve multiple kibibytes. As asking the OS for memory requires a system call, this is also extremely inefficient for speed.
//Here, we allocate 100 bytes as a []u8. Notice how defer is used in conjunction with a free - this is a common pattern for memory management in Zig.

test "allocation" {
    const allocator = std.heap.page_allocator;

    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);

    try expect(memory.len == 100);
    try expect(@TypeOf(memory) == []u8);
}

//alloc and free are used for slices. For single items, consider using create and destroy.

test "allocator create/destroy" {
    const byte = try std.heap.page_allocator.create(u8);
    defer std.heap.page_allocator.destroy(byte);
    byte.* = 128;
}
