require 'test_helper'

class TC_Eigen_Isometry3 < Minitest::Test
    def test_base
        v = Eigen::Vector3.new(1, 2, 3)
	q = Eigen::Quaternion.new(1, 0, 0, 0)
	t = Eigen::Isometry3.from_position_orientation( v, q )

	vt = t.translation
	qt = t.rotation
	assert_equal( v, vt )
	assert_equal( q, qt )
    end

    def test_rotation
        v = Eigen::Vector3.new(0, 0, 0)
	q = Eigen::Quaternion.from_angle_axis( 1.2, Eigen::Vector3.new( 0.1, 0.2, 0.3 ).normalize() ) 
	t = Eigen::Isometry3.from_position_orientation( v, q )

	p1 = Eigen::Vector3.new(1,1,1)
        assert_approx_equal (t * p1), (q * p1)
        assert_approx_equal (t.rotation * p1), (q * p1)

	vt = t.translation
	qt = t.rotation
	assert_approx_equal v, vt
	assert_approx_equal q, qt
    end

    def test_composition
        v = Eigen::Vector3.new(1, 2, 3)
	q = Eigen::Quaternion.new(0, 0, 1, 0)
	t = Eigen::Isometry3.from_position_orientation( v, q )

        v2 = Eigen::Vector3.new(1, 2, 3)
	q2 = Eigen::Quaternion.new(0, 0, 1, 0)
	t2 = Eigen::Isometry3.from_position_orientation( v2, q2 )

	# transform a vector
	p = Eigen::Vector3.new( 0, 0, 0 )
	r = t * p

	assert_equal( Eigen::Vector3.new( 1, 2, 3 ), r )

	# perform composite
	c = t2 * t
	assert_equal( 
	    Eigen::Isometry3.from_position_orientation( 
		Eigen::Vector3.new( 0, 4, 0 ), Eigen::Quaternion.Identity ), 
		c )
    end

    def test_inverse
        v = Eigen::Vector3.new(1, 2, 3)
	q = Eigen::Quaternion.new(0, 0, 1, 0)
	t = Eigen::Isometry3.from_position_orientation( v, q )

	i = t.inverse() * t 

	assert_equal( i, Eigen::Isometry3.Identity )
    end

    def test_approx_p_returns_true_on_equality
        v = Eigen::Vector3.new(1, 2, 3)
        q = Eigen::Quaternion.new(1, 0, 0, 0)
        t = Eigen::Isometry3.from_position_orientation( v, q )
        assert_approx_equal t, t
    end

    def test_approx_p_returns_true_on_inequality
        v = Eigen::Vector3.new(1, 2, 3)
        q = Eigen::Quaternion.new(1, 0, 0, 0)
        t1 = Eigen::Isometry3.from_position_orientation( v, q )
        v = Eigen::Vector3.new(2, 2, 3)
        q = Eigen::Quaternion.new(1, 0, 0, 0)
        t2 = Eigen::Isometry3.from_position_orientation( v, q )
        refute_approx_equal t1, t2
    end
end
