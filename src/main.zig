const std = @import("std");
const decimal = @import("decimal.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    while (true) {
        try stdout.print("Letś convert to hexadecimal numbers.\n", .{});

        const guess = try ask_user();
        const dont_fail_please = try decimal.decimalHexadecimal(guess);
        _ = dont_fail_please;

        try stdout.print("Here we are again.\n", .{});
    }
}

fn ask_user() !i32 {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [10]u8 = undefined;

    try stdout.print("Write a number: ", .{});

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
        return std.fmt.parseInt(i32, user_input, 10);
    } else {
        return error.InvalidParam;
    }
}