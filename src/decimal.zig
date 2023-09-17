// Examples
const std = @import("std");
const expect = std.testing.expect;
const math = @import("std").math;
const BASE_HEXA = 16;
pub const Error = error{EverythingIsBroken};
const stdout = std.io.getStdOut().writer();
pub fn decimalHexadecimal(decimal: i32) Error!i32 {
    var remainder = [_]u8{};
    _ = remainder;
    var quotient = decimal;

    var count: i32 = 0;

    var validate_hexa: i32 = 0x0;
    while (quotient != 0) {
        const scoped_remainder = @rem(quotient, BASE_HEXA);
        const base = math.pow(i32, BASE_HEXA, @as(i32, count));
        if (scoped_remainder > 9 and scoped_remainder < 16) {
            switch (scoped_remainder) {
                10 => {
                    validate_hexa += 0xA * base;
                },
                11 => {
                    validate_hexa = 0xB * base;
                },
                12 => {
                    validate_hexa = 0xC * base;
                },
                13 => {
                    validate_hexa = 0xD * base;
                },
                14 => {
                    validate_hexa = 0xE * base;
                },
                15 => {
                    validate_hexa += 0xF * base;
                },
                else => {},
            }
        } else {
            const y = @as(i32, scoped_remainder);
            validate_hexa += y * base;
        }
        quotient = @divTrunc(quotient, BASE_HEXA);
        count += 1;
    }
    if (validate_hexa == decimal) {
        stdout.print("Hexadecimal value {x:0>2}\n", .{validate_hexa}) catch {};
    } else {
        stdout.print("everything is broken ˙◠˙", .{}) catch {};
        return error.EverythingIsBroken;
    }

    return validate_hexa;
}
pub fn decimalOctal() u16 {
    return 0o755;
}

pub fn decimalBinary() u8 {
    return 0b1111_0000;
}

test "check hexadecimal conversion, expected value must be the same of input" {
    // arrange
    const expected_value = 800;

    //act
    var value = decimalHexadecimal(800) catch |err| {
        // assert error
        try expect(err == error.EverythingIsBroken);
        return;
    };

    // assert
    try expect(value == expected_value);
}
