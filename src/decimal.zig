// Imports
const std = @import("std");
const expect = std.testing.expect;
const math = @import("std").math;
const stdout = std.io.getStdOut().writer();
const bufPrint = std.fmt.bufPrint;

// Const values
const BASE_HEXA = 16;
const BASE_OCTAL = 8;
const BASE_BINARY = 2;
pub const Error = error{ EverythingIsBroken, NoSpaceLeft };

pub fn decimalHexadecimal(decimal: i64) Error!i64 {
    var quotient = decimal;

    var count: i32 = 0;

    var validate_hexa: i64 = 0x0;
    while (quotient != 0) {
        const scoped_remainder = @rem(quotient, BASE_HEXA);
        const base = math.pow(i32, BASE_HEXA, @as(i32, count));
        if (scoped_remainder > 9 and scoped_remainder < 16) {
            switch (scoped_remainder) {
                10 => {
                    validate_hexa += 0xA * base;
                },
                11 => {
                    validate_hexa += 0xB * base;
                },
                12 => {
                    validate_hexa += 0xC * base;
                },
                13 => {
                    validate_hexa += 0xD * base;
                },
                14 => {
                    validate_hexa += 0xE * base;
                },
                15 => {
                    validate_hexa += 0xF * base;
                },
                else => {},
            }
        } else {
            validate_hexa += scoped_remainder * base;
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
pub fn decimalOctal(decimal: i64) Error!i64 {
    var quotient = decimal;

    var count: i32 = 0;

    var validate_octal: i64 = 0o0;
    while (quotient != 0) {
        const scoped_remainder = @rem(quotient, BASE_OCTAL);
        const base = math.pow(i32, BASE_OCTAL, @as(i32, count));

        if (scoped_remainder > 8) {
            validate_octal += scoped_remainder - 2 * base;
        } else {
            validate_octal += scoped_remainder * base;
        }
        quotient = @divTrunc(quotient, BASE_OCTAL);
        count += 1;
    }
    if (validate_octal == decimal) {
        stdout.print("Octal value {o}\n", .{validate_octal}) catch {};
    } else {
        stdout.print("everything is broken ˙◠˙", .{}) catch {};
        return error.EverythingIsBroken;
    }
    return validate_octal;
}

pub fn decimalBinary(decimal: i64) Error!i64 {
    var quotient = decimal;

    var count: i32 = 0;

    var validate_binary: i64 = 0b0;
    while (quotient != 0) {
        const scoped_remainder = @rem(quotient, BASE_BINARY);
        const base = math.pow(i32, BASE_BINARY, @as(i32, count));

        validate_binary += scoped_remainder * base;

        quotient = @divTrunc(quotient, BASE_BINARY);
        count += 1;
    }
    if (validate_binary == decimal) {
        stdout.print("Binary value {b}\n", .{validate_binary}) catch {};
    } else {
        stdout.print("everything is broken ˙◠˙", .{}) catch {};
        return error.EverythingIsBroken;
    }
    return validate_binary;
}

test "check hexadecimal conversioni with random nunmbe, expected value must be the same of input" {
    // arrange
    const RndGen = std.rand.DefaultPrng;
    var rnd = RndGen.init(0);
    var some_random_num = rnd.random().int(i32);
    try stdout.print("Value generated: {d} ", .{some_random_num});
    //act
    var value = decimalHexadecimal(some_random_num) catch |err| {
        // assert error
        try expect(err == error.EverythingIsBroken);
        return;
    };

    // assert
    try expect(value == some_random_num);
}

test "check hexadecimal conversion, expected value must be the same of input (specific)" {
    // arrange
    const expected_value = 452;
    try stdout.print("Specific value: {d} ", .{expected_value});

    //act
    var value = decimalHexadecimal(452) catch |err| {
        // assert error
        try expect(err == error.EverythingIsBroken);
        return;
    };

    // assert
    try expect(value == expected_value);
}

test "check octal conversion, expected value must be the same of input" {
    // arrange
    const RndGen = std.rand.DefaultPrng;
    var rnd = RndGen.init(0);
    var some_random_num = rnd.random().int(i32);
    try stdout.print("Value generated: {d} ", .{some_random_num});

    //act
    var value = decimalOctal(some_random_num) catch |err| {
        // assert error
        try expect(err == error.EverythingIsBroken);
        return;
    };

    // assert
    try expect(value == some_random_num);
}

test "check octal conversion, expected value must be the same of input (specific)" {
    // arrange
    const expected_value = 297;
    try stdout.print("Specific value: {d} ", .{expected_value});

    //act
    var value = decimalOctal(297) catch |err| {
        // assert error
        try expect(err == error.EverythingIsBroken);
        return;
    };

    // assert
    try expect(value == expected_value);
}

test "check binary conversion, expected value must be the same of input" {
    // arrange
    const RndGen = std.rand.DefaultPrng;
    var rnd = RndGen.init(0);
    var some_random_num = rnd.random().int(i32);
    try stdout.print("Value generated: {d} ", .{some_random_num});

    //act
    var value = decimalBinary(some_random_num) catch |err| {
        // assert error
        try expect(err == error.EverythingIsBroken);
        return;
    };

    // assert
    try expect(value == some_random_num);
}

test "check binary conversion, expected value must be the same of input (specific)" {
    // arrange
    const expected_value = 582;
    try stdout.print("Specific value: {d} ", .{expected_value});

    //act
    var value = decimalBinary(582) catch |err| {
        // assert error
        try expect(err == error.EverythingIsBroken);
        return;
    };

    // assert
    try expect(value == expected_value);
}
