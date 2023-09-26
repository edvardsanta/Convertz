const std = @import("std");
const decimal = @import("decimal.zig");
const expect = std.testing.expect;
const eql = std.mem.eql;
const bufPrint = std.fmt.bufPrint;
pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    while (true) {
        try stdout.print("Letś convert to hexadecimal, octal and binary numbers.\n", .{});

        const guess = try ask_user();
        const dont_fail_please = try decimal.decimalHexadecimal(guess);
        _ = dont_fail_please;

        const dont_fail_please_octal = try decimal.decimalOctal(guess);
        _ = dont_fail_please_octal;

        const dont_fail_please_bit = try decimal.decimalBinary(guess);
        _ = dont_fail_please_bit;

        try stdout.print("Here we are again.\n", .{});
    }
}

fn ask_user() !i64 {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [10]u8 = undefined;

    try stdout.print("Write a number: ", .{});

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
        return std.fmt.parseInt(i64, user_input, 10);
    } else {
        return error.InvalidParam;
    }
}
