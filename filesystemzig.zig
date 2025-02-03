const std = @import("std");
const expect = std.testing.expect;
const eql  = std.mem.eql;
//Let's create and open a file in our current working directory, write to it, and then read from it. Here we have to use .seekTo to go back to the start of the file before reading what we have written.

test "createFile, write, seekTo, read" {
    const file = try std.fs.cwd().createFile("mainfile.txt",.{.read=true}, );
    defer file.close();

    try file.writeAll("Hello file");

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);

    try expect(eql(u8, buffer[0..bytes_read],"Hello file"));
}
