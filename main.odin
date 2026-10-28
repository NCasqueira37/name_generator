package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:math/rand"

names_arr: [dynamic]string

main :: proc() {
	if len(os.args) < 2 {
		fmt.println("Usage: name_generator <file_name> <random, linecount, longest>")
		return
	}

	file := os.args[1]
	action := os.args[2]

	data, err := os.read_entire_file(file, context.allocator)
	if err != nil {
		fmt.println("File not found.")
		return
	}

	// add data to array
	string_data := string(data[:])
	for line in strings.split_lines_iterator(&string_data) {
		append(&names_arr, line)
	}
	switch action {
	case "random":
		fmt.println(get_random_name(names_arr[:]))
	case "linecount":
		fmt.println(get_line_count(names_arr[:]))
	case "longest":
		fmt.println(get_longest_name(names_arr[:]))
	}
}

get_random_name :: proc(arr: []string) -> string{
	return arr[rand.int_range(0, len(arr))]
}

get_line_count :: proc(arr: []string) -> int{
	return len(arr)
}

get_longest_name :: proc(arr: []string) -> string {
	result: string
	for name in arr {
		if len(name) > len(result) {
			result = name
		}
	}
	return result
}

