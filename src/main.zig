const std = @import("std");
const decimal = @import("decimal.zig");
const Factory = @import("cli.zig").ConverterFactory;
const expect = std.testing.expect;
const bufPrint = std.fmt.bufPrint;
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    const stdout = std.io.getStdOut().writer();

    if (args.len > 1) {
        const factory = try Factory.new();
        try factory.calculate_with_params(&args);
        return;
    }
    while (true) {
        try stdout.print("Letś convert to hexadecimal, octal and binary numbers.\n", .{});

        const guess = try ask_user();
        const dont_fail_please_hexadecimal = try decimal.decimalHexadecimal(guess);
        _ = dont_fail_please_hexadecimal;

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
