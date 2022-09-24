# Numo::Linalg.rand_svd

Numo::Linalg.rand_svd is a module function on Numo::Linalg for truncated singular value decomposition with randomized algorithm.
This gem re-implements [RandSVD](https://github.com/yoshoku/randsvd) using [Numo::NArray](https://github.com/ruby-numo/numo-narray) and
[Numo::Linalg](https://github.com/ruby-numo/numo-linalg) instead of [NMatrix](https://github.com/SciRuby/nmatrix).

References:

- P.-G. Martinsson, A. Szlam, M. Tygert, "Normalized power iterations for the computation of SVD," Proc. of NIPS Workshop on Low-Rank Methods for Large-Scale Machine Learning, 2011.
- P.-G. Martinsson, V. Rokhlin, M. Tygert, "A randomized algorithm for the approximation of matrices," Tech. Rep., 1361, Yale University Department of Computer Science, 2006.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'numo-linalg-randsvd'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install numo-linalg-randsvd

## Usage

```ruby
require 'numo/linalg/autoloader'
require 'numo/linalg/randsvd'

x = Numo::DFloat.new(100, 50).rand
y = Numo::DFloat.new(20, 50).rand
z = x.dot(y)

p z
# Numo::DFloat#shape=[100,50]
# ...

n_singular_values = 20
s, u, vt = Numo::Linalg.rand_svd(z, n_singular_values)

p s
# Numo::DFloat#shape=[20]
# ...

p u
# Numo::DFloat#shape=[100,20]
# ...

p vt
# Numo::DFloat#shape=[20,50]
# ...

zz = u.dot(s.diag).dot(vt)
p zz
# Numo::DFloat#shape=[100,50]
# ...

p (z - zz).abs.max
# 5.5067062021407764e-14
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yoshoku/numo-linalg-randsvd.
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the [code of conduct](https://github.com/yoshoku/numo-linalg-randsvd/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [BSD-3-Clause License](https://opensource.org/licenses/BSD-3-Clause)
