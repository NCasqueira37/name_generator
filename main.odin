package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:math/rand"

main :: proc() {
	data, err := os.read_entire_file("names.txt", context.allocator)
	if err != nil {return}

	names_arr: [dynamic]string
	string_data := string(data[:])
	for line in strings.split_lines_iterator(&string_data) {
		append(&names_arr, line)
	}
	
	name_picked := names_arr[rand.int_range(0, len(names_arr))]
	fmt.println(name_picked)
}