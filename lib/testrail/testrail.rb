lib_path = Pathname.new(__dir__).realpath.to_s

Dir.glob(lib_path + '/**/*.rb').
  map    { |path| path.gsub("#{lib_path}/", '').gsub('.rb', '') }.
  reject { |path| path == 'testrail' }.
  each   { |path| require path }
