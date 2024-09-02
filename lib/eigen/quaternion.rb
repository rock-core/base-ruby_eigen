# frozen_string_literal: true

module Eigen
    # Representation and manipulation of a quaternion
    class Quaternion
        def dup
            Quaternion.new(w, x, y, z)
        end

        # Returns the quaternion as [w, x, y, z]
        def to_a
            [w, x, y, z]
        end

        # Returns the identity unit quaternion (identity rotation)
        def self.Identity
            Quaternion.new(1, 0, 0, 0)
        end

        # DEPRECATED: please use identity instead. Returns the unit quaternion
        # (identity rotation)
        def self.Unit # rubocop:disable Naming/MethodName
            warn "[DEPRECATED] Quaternion.unit, please use Quaternion.identity."
            self.Identity
        end

        # Creates a quaternion from an angle and axis description
        def self.from_angle_axis(*args)
            q = new(1, 0, 0, 0)
            q.from_angle_axis(*args)
            q
        end

        # Returns an angle,axis representation equivalent to this quaternion
        #
        # If the angle turns out to be PI, there are two solutions and the one
        # with positive Z component is chosen.
        #
        # @param [Float] eps if the angle turns out to be closer to zero than eps, the
        #   rotation axis is undefined and chosen to be the Z axis.
        #
        # @return [(Float,Vector3)] the angle and axis. The angle is in [0, PI]
        def to_angle_axis(eps = 1e-12)
            w, x, y, z = to_a
            norm  = Math.sqrt(x * x + y * y + z * z)
            return 0, Eigen::Vector3.new(0, 0, 1) if norm < eps

            angle = 2.0 * Math.atan2(norm, w)
            axis  = Eigen::Vector3.new(x, y, z) / norm
            [angle, axis]
        end

        # Returns a scaled axis representation that is equivalent to this
        # quaternion
        #
        # @param [Float] eps see {#to_angle_axis}
        # @return [Vector3]
        def to_scaled_axis(eps = 1e-12)
            angle, axis = to_angle_axis(eps)
            axis * angle
        end

        # Creates a quaternion from a set of euler angles.
        #
        # See Quaternion#from_euler for details
        def self.from_euler(*args)
            q = new(1, 0, 0, 0)
            q.from_euler(*args)
            q
        end

        # Creates a quaternion from a rotation matrix
        def self.from_matrix(m)
            q = new(1, 0, 0, 0)
            q.from_matrix(m)
            q
        end

        # Extracts the yaw angle from this quaternion
        #
        # It decomposes the quaternion in euler angles using to_euler
        # and returns the first element. See #to_euler for details.
        def yaw
            to_euler[0]
        end

        def pitch
            to_euler[1]
        end

        def roll
            to_euler[2]
        end

        # The inverse of #yaw
        def self.from_yaw(yaw)
            from_euler(Eigen::Vector3.new(yaw, 0, 0), 2, 1, 0)
        end

        # Concatenates with another quaternion or transforms a vector
        def *(other)
            if other.kind_of?(Quaternion)
                concatenate(other)
            else
                transform(other)
            end
        end

        def _dump(_level) # :nodoc:
            Marshal.dump(to_a)
        end

        def self._load(coordinates) # :nodoc:
            new(*Marshal.load(coordinates))
        end

        def to_s # :nodoc:
            "Quaternion(#{w}, (#{x}, #{y}, #{z}))"
        end

        # Tests for equality
        #
        # Since Quaternion stores the coordinates as floating-point values, this is
        # a bad test. Use
        #
        #   (v - other_v).norm < threshold
        #
        # instead
        def ==(other)
            other.kind_of?(self.class) &&
                __equal__(other)
        end

        def re
            w
        end

        def re=(value)
            self.w = value
        end

        def im
            [x, y, z]
        end

        def im=(value)
            self.x, self.y, self.z = *value
        end

        ##
        # :method: w

        ##
        # :method: x

        ##
        # :method: y

        ##
        # :method: z

        ##
        # :method: w=

        ##
        # :method: x=

        ##
        # :method: y=

        ##
        # :method: z=

        ##
        # :method: concatenate
        # :call-seq:
        #   concatenate(q)
        #
        # Returns the rotation in which +q+ is applied first and +self+ second

        ##
        # :method: transform
        # :call-seq:
        #   transform(v)
        #
        # Transforms the given Eigen::Vector3 by the rotation represented with
        # this quaternion

        ##
        # :method: normalize!
        #
        # Normalizes this quaternion

        ##
        # :method: normalize
        #
        # Returns a quaternion that is a normalized version of +self+

        ##
        # :method: approx?
        # :call-seq:
        #   approx?(q, tolerance)
        #
        # Returns true if +self+ and +q+ do not differ from more than
        # +tolerance+. The comparison is done on a coordinate basis.

        ##
        # :method: to_euler
        # :call-seq:
        #    to_euler => Eigen::Vector3(a0, a1, a2)
        #
        # Decomposes this quaternion in euler angles so that +self+ can be
        # obtained by applying the following rotations in order:
        #
        #   rotation of a2 around x-axis
        #   rotation of a1 around y-axis
        #   rotation of a0 around z-axis
        #
        #   assuming angles in range of: a0:(-pi,pi), a1:(-pi/2,pi/2), a2:(-pi/2,pi/2)
        #
        # note that
        #
        #   self == Quaternion.from_euler(to_euler, axis0, axis1, axis2)

        ##
        # :method: from_euler
        # :call-seq:
        #    from_euler(Eigen::Vector3(a0, a1, a2), axis0, axis1, axis2)
        #
        # Resets this quaternion so that it represents the rotation obtained by
        # applying the following rotations in order:
        #
        #   rotation of a2 around axis2
        #   rotation of a1 around axis1
        #   rotation of a0 around axis0
        #
        # note that
        #
        #   self == Quaternion.from_euler(to_euler, axis0, axis1, axis2)

        ##
        # :method: inverse
        # :call-seq:
        #   inverse => quaternion
        #
        # Computes the quaternion that is inverse of this one

        # @return [Qt::Quaternion] the Qt quaternion that is identical to this
        # one
        def to_qt
            Qt::Quaternion.new(w, x, y, z)
        end
    end
end
