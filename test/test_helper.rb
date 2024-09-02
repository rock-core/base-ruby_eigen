# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

# simplecov must be loaded FIRST. Only the files required after it gets loaded
# will be profiled !!!
if ENV["TEST_ENABLE_COVERAGE"] == "1"
    begin
        require "simplecov"
        SimpleCov.start
    rescue LoadError
        require "eigen"
        warn "coverage is disabled because the 'simplecov' gem cannot be loaded"
    rescue StandardError => e
        require "eigen"
        warn "coverage is disabled: #{e.message}"
    end
end

require "eigen"
require "minitest/autorun"

module Eigen
    # This module is the common setup for all tests
    #
    # It should be included in the toplevel describe blocks
    #
    # @example
    #   require 'test_helper'
    #   describe Eigen do
    #   end
    #
    module SelfTest
        def assert_approx_equal(expected, actual, tolerance = 0.0001)
            assert(expected.approx?(actual, tolerance),
                   "expected #{expected} to be approximately equal to #{actual}")
        end

        def refute_approx_equal(expected, actual, tolerance = 0.0001)
            refute(expected.approx?(actual, tolerance),
                   "expected #{expected} to not be approximately equal to #{actual}")
        end
    end
end

module Minitest
    class Test
        include Eigen::SelfTest
    end
end
