require 'test_helper'

module Eigen
    describe Matrix4 do
        attr_reader :matrix
        before do
            @matrix = Matrix4.new
        end
        describe "#from_a" do
            describe "column_major=true" do
                it "sets all the matrix values from the given array" do
                    matrix.from_a((0..15).to_a)
                    4.times do |col|
                        4.times do |row|
                            assert_equal (col * 4 + row), matrix[row, col]
                        end
                    end
                end
                it "raises if the array is bigger than 16" do
                    e = assert_raises(ArgumentError) do
                        matrix.from_a((1..17).to_a)
                    end
                    assert_match "array should be of size maximum 16", e.message
                end
                it "completes missing values with zeroes if the array is smaller than 16" do
                    matrix.from_a((0..12).to_a)
                    assert_equal 0, matrix[1, 3]
                    assert_equal 0, matrix[2, 3]
                    assert_equal 0, matrix[3, 3]
                end
            end
            describe "column_major=false" do
                it "sets all the matrix values from the given array" do
                    matrix.from_a((0..15).to_a, false)
                    4.times do |col|
                        4.times do |row|
                            assert_equal (col + row * 4), matrix[row, col]
                        end
                    end
                end
                it "raises if the array is bigger than 16" do
                    e = assert_raises(ArgumentError) do
                        matrix.from_a((1..17).to_a, false)
                    end
                    assert_match "array should be of size maximum 16", e.message
                end
                it "completes missing values with zeroes if the array is smaller than 16" do
                    matrix.from_a((0..12).to_a, false)
                    assert_equal 0, matrix[3, 1]
                    assert_equal 0, matrix[3, 2]
                    assert_equal 0, matrix[3, 3]
                end
            end
        end
        describe "#to_a" do
            before do
                matrix.from_a((1..16).to_a)
            end
            describe "column_major=true" do
                it "returns the matrix values" do
                    array = matrix.to_a
                    assert_equal (1..16).to_a, array
                end
            end
            describe "column_major=false" do
                it "returns the matrix values in row-major order" do
                    array = matrix.to_a(false)
                    assert_equal [1, 5, 9, 13, 2, 6, 10, 14, 3, 7, 11, 15, 4, 8, 12, 16], array
                end
            end
        end
        describe "marshalling and demarshalling" do
            before do
                matrix.from_a((1..16).to_a)
            end
            it "can unmarshal a value that had been marshalled with the old _dump method" do
                def matrix._dump(level)
                    Marshal.dump({'rows' => rows, 'cols' => cols, 'data' => to_a})
                end
                marshalled = Marshal.dump(matrix)
                unmarshalled = Marshal.load(marshalled)
                assert_equal (1..16).to_a, unmarshalled.to_a
            end
            it "can marshal/unmarshal with the new method" do
                marshalled = Marshal.dump(matrix)
                unmarshalled = Marshal.load(marshalled)
                assert_equal (1..16).to_a, unmarshalled.to_a
            end
        end
    end
end

