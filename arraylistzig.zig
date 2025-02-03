//The std.ArrayList is commonly used throughout Zig, and serves as a buffer that can change in size. std.ArrayList(T) is similar to C++'s std::vector<T> and Rust's Vec<T>. The deinit() method frees all of the ArrayList's memory. The memory can be read from and written to via its slice field - .items.
const std = @import("std");
const expect = std.testing.expect;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

test "arraylist"{
    var list = ArrayList(u8).init(test_allocator);
    defer list.deinit();
    try list.append('L');
    try list.append('I');
    try list.append('N');
    try list.append('U');
    try list.append('X');

    try list.appendSlice(" Arch");

    try expect(eql(u8,list.items ,"LINUX Arch" ));
}
