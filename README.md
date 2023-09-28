# Convertz


## Overview
This project is a simple command-line tool built in Zig that allows you to convert decimal numbers into their hexadecimal, 
octal, and binary representations. It's a handy utility for programmers and anyone who needs to work with different number formats.

## Getting Started
### Prerequisites
Before you can use this tool, you'll need to have Zig installed on your system. 
You can download and install Zig (0.11) from the [official website](https://ziglang.org/download/), 
with this asdf plugin: [asdf-zig](https://github.com/asdf-community/asdf-zig.git)
or with [zigup](https://github.com/marler8997/zigup.git)

### Usage
1. You can execute:
```shell
zig build run 
```
2. Or you can pass arguments
``` shell
./convertz hex 452
```
```shell
./convertz oct 452
```
```shell
./convertz bin 452
```


