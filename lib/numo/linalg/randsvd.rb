# frozen_string_literal: true

require 'numo/narray'

# Ruby/Numo (NUmerical MOdules)
module Numo
  # Numo::Linalg : Linear Algebra library with BLAS/LAPACK binding to Numo::NArray
  module Linalg
    module_function

    # Compute the randomized singular value decompostion.
    #
    # @param a [Numo::NArray] The m-by-n input matrix to be decomposed.
    # @param k [Integer] The number of singular values.
    # @param t [Integer] The number of iterations for orthogonalization.
    # @param driver [String] The driver parameter of Numo::Linalg.svd.
    # @param job [String] The job parameter of Numo::Linalg.svd.
    def rand_svd(a, k, t = 0, driver: 'svd', job: 'A')
      n = a.shape[1]
      q = _orthonormal_mat(a, [k + 10, n].min, t)
      b = a.dot(q)
      s, u, vt = Numo::Linalg.svd(b, driver: driver, job: job)
      vtqt = vt.dot(q.transpose)
      _truncated_mat(s, u, vtqt, k)
    end

    def _rand_normal(shape, dtype = Numo::DFloat, mu = 0.0, sigma = 1.0)
      a = dtype.new(shape).rand
      b = dtype.new(shape).rand
      ((Numo::NMath.sqrt(Numo::NMath.log(a) * -2.0) * Numo::NMath.sin(b * 2.0 * Math::PI)) * sigma) + mu
    end

    def _orthonormal_mat(a, l, t)
      m = a.shape[0]
      r = _rand_normal([m, l], a.class)
      q, = Numo::Linalg.qr(a.transpose.dot(r), mode: 'economic')
      t.times do
        r, = Numo::Linalg.qr(a.dot(q), mode: 'economic')
        q, = Numo::Linalg.qr(a.transpose.dot(r), mode: 'economic')
      end
      q
    end

    def _truncated_mat(s, u, vt, k)
      m = u.shape[0]
      n = vt.shape[1]
      [s[0...k].dup, u[0...m, 0...k].dup, vt[0...k, 0...n].dup]
    end

    private_class_method :_rand_normal, :_orthonormal_mat, :_truncated_mat
  end
end
