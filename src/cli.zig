const std = @import("std");
const eql = std.mem.eql;
const decimal = @import("decimal.zig");
const stdout = std.io.getStdOut().writer();

// it will be better when i created hex to dec, bin to octal, etc
pub const ConverterFactory = struct {
    const ConverterType = enum {
        Hex,
        Oct,
        Bin,
        Invalid,
    };

    fn identify_converter_type(input: []const u8) ConverterType {
        if (eql(u8, input, "hex")) {
            return .Hex;
        } else if (eql(u8, input, "oct")) {
            return .Oct;
        } else if (eql(u8, input, "bin")) {
            return .Bin;
        } else {
            return .Invalid;
        }
    }

    pub fn new() !ConverterFactory {
        const factory = ConverterFactory{};
        return factory;
    }

    pub fn calculate_with_params(self: *const ConverterFactory, args: *const [][:0]u8) !void {
        _ = self;
        var systemNumberToParse = args.ptr[1];
        var numberToParse = try std.fmt.parseInt(i64, args.ptr[2], 10);

        const converterType = identify_converter_type(systemNumberToParse);

        switch (converterType) {
            .Hex => {
                const dont_fail_please_hexadecimal = try decimal.decimalHexadecimal(numberToParse);
                _ = dont_fail_please_hexadecimal;
            },
            .Oct => {
                const dont_fail_please_octal = try decimal.decimalOctal(numberToParse);
                _ = dont_fail_please_octal;
            },
            .Bin => {
                const dont_fail_please_bit = try decimal.decimalBinary(numberToParse);
                _ = dont_fail_please_bit;
            },
            .Invalid => {
                try stdout.print("Invalid converter", .{});
            },
        }
    }
};
