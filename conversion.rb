require 'pry'

# `git diff --name-status HEAD..HEAD~x`

file_list = <<-EOF

EOF

def generate_tree(list_of_file_path_arrays)
  x = Marshal.load(Marshal.dump(list_of_file_path_arrays))
  grouped_paths = x.group_by{|path| path.shift }

  bottom_level_files = []
  sub_dir_hash  = {}

  grouped_paths.each do |k, list_of_sub_paths|
    if list_of_sub_paths.length == 1 && list_of_sub_paths.first.empty?
      bottom_level_files << k
    else
      sub_dir_hash[k] = generate_tree(list_of_sub_paths)
    end
  end

  { files: bottom_level_files, dirs: sub_dir_hash }
end

def hierarchy_string(thing, depth=0)
  newline_indent = "\n#{'    ' * depth}"

  files = thing[:files]
  dirs = thing[:dirs]

  output_string = ""
  unless files.empty?
    output_string += files.map { |f| newline_indent + f }.join()
  end

  unless dirs.empty?
    dirs.each do |name, sub_files|
      output_string += (newline_indent + name)
      output_string += hierarchy_string(sub_files, depth + 1)
    end
  end

  output_string
end

list_of_paths = file_list.split("\n").map do |line|
  path_array = line.split('/')
end

puts hierarchy_string(generate_tree(list_of_paths))









