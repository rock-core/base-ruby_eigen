# frozen_string_literal: true

require "mkmf-rice"

RbConfig::CONFIG["CXXFLAGS"].gsub! "-Wdeclaration-after-statement", ""
RbConfig::CONFIG["CXXFLAGS"].gsub! "-Wimplicit-function-declaration", ""

unless pkg_config("eigen3")
    raise "cannot find the eigen3 pkg-config package in #{ENV.fetch('PKG_CONFIG_PATH',
                                                                    nil)}"
end

create_makefile("eigen/eigen")
