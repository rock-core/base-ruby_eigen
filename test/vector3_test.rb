require 'test_helper'

class TC_Eigen_Vector3 < Minitest::Test
    def test_base
        v = Eigen::Vector3.new(1, 2, 3)
        assert_equal(1, v.x)
        assert_equal(2, v.y)
        assert_equal(3, v.z)
    end

    def test_add
        v0 = Eigen::Vector3.new(1, 2, 3)
        v1 = Eigen::Vector3.new(-1, -2, -3)
        assert_equal([0, 0, 0], (v0 + v1).to_a)
    end

    def test_sub
        v0 = Eigen::Vector3.new(1, 2, 3)
        v1 = Eigen::Vector3.new(-1, -2, -3)
        assert_equal([2, 4, 6], (v0 - v1).to_a)
    end

    def test_opposite
        v0 = Eigen::Vector3.new(1, 2, 3)
        assert_equal([-1, -2, -3], (-v0).to_a)
    end

    def test_scale
        v0 = Eigen::Vector3.new(1, 2, 3)
        assert_equal([2, 4, 6], (v0 * 2).to_a)
    end

    def test_div_by_scalar
        v0 = Eigen::Vector3.new(2, 4, 6)
        assert_equal([1, 2, 3], (v0 / 2.0).to_a)
    end

    def test_dump_load
        v = Eigen::Vector3.new(0.2, 0.5, 0.1)
        dumped = Marshal.dump(v)
        loaded = Marshal.load(dumped)
        assert_equal v, loaded
    end

    def test_dup
        v = Eigen::Vector3.new(0.2, 0.5, 0.1)
        new = v.dup
        assert_equal v, new
    end

    def test_approx_returns_true_on_equal_vectors
        v = Eigen::Vector3.new(0, 0, 0)
        assert_approx_equal v, v
    end

    def test_approx_returns_true_on_vectors_that_are_different_by_epsilon
        v1 = Eigen::Vector3.new(1, 1, 1)
        v2 = Eigen::Vector3.new(1 + Float::EPSILON, 1, 1)
        assert_approx_equal v1, v2
    end

    def test_approx_returns_false_on_vectors_that_are_different
        v1 = Eigen::Vector3.new(1, 1, 1)
        v2 = Eigen::Vector3.new(2, 2, 2)
        refute_approx_equal v1, v2
    end

    def test_approx_returns_true_on_vectors_that_are_less_different_than_the_provided_accuracy
        v1 = Eigen::Vector3.new(1, 1, 1)
        v2 = Eigen::Vector3.new(1.5, 1.5, 1.5)
        assert_approx_equal v1, v2, 2
    end

    def test_data_assign
        v = Eigen::Vector3.new(0, 0, 0)
        v.data = [1, 2, 3]
        assert_equal v, Eigen::Vector3.new(1, 2, 3)
    end
end

