const std = @import("std");
const expect = std.testing.expect;

//The Zig standard library also has a general-purpose allocator. This is a safe allocator that can prevent double-free, use-after-free and can detect leaks. Safety checks and thread safety can be turned off via its configuration struct (left empty below). Zig's GPA is designed for safety over performance, but may still be many times faster than page_allocator.

test "GPA" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer{
        const deinit_status = gpa.deinit();
         //fail test; can't try in defer as defer is executed after we return
        if(deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }
    const bytes = try allocator.alloc(u8,100, );
    defer allocator.free(bytes);
}
