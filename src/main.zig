const std = @import("std");
const decimal = @import("decimal.zig");
const expect = std.testing.expect;
const eql = std.mem.eql;
const bufPrint = std.fmt.bufPrint;
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    const stdout = std.io.getStdOut().writer();

    // TODO separate this is another file
    if (args.len > 1) {
        std.debug.print("Arguments: {s}\n", .{args});
        var systemNumberToParse = args[1];
        var numberToParse = try std.fmt.parseInt(i64, args[2], 10);
        if (eql(u8, systemNumberToParse, "hex")) {
            const dont_fail_please_hexadecimal = try decimal.decimalHexadecimal(numberToParse);
            _ = dont_fail_please_hexadecimal;
        } else if (eql(u8, systemNumberToParse, "oct")) {
            const dont_fail_please_octal = try decimal.decimalOctal(numberToParse);
            _ = dont_fail_please_octal;
        } else if (eql(u8, systemNumberToParse, "bin")) {
            const dont_fail_please_bit = try decimal.decimalBinary(numberToParse);
            _ = dont_fail_please_bit;
        } else {
            try stdout.print("Invalid converter", .{});
        }
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
