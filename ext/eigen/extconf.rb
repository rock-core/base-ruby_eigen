require "mkmf-rice"

RbConfig::CONFIG['CXXFLAGS'].gsub! "-Wdeclaration-after-statement", ''
RbConfig::CONFIG['CXXFLAGS'].gsub! "-Wimplicit-function-declaration", ''

if !pkg_config('eigen3')
    raise "cannot find the eigen3 pkg-config package in #{ENV['PKG_CONFIG_PATH']}"
end

create_makefile("eigen/eigen")
