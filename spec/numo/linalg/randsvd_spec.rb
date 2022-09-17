# frozen_string_literal: true

RSpec.describe Numo::Linalg do
  describe '#rand_svd' do
    let(:m) { 500 }
    let(:n) { 50 }
    let(:k) { 5 }
    let(:a) { (Numo::DFloat.new(m, k).rand - 0.5).dot(Numo::DFloat.new(k, n).rand - 0.5) }

    it 'perfoms the singular value decomposition of a rectangular real matrix', :aggregate_failures do
      s, u, vt = described_class.rand_svd(a, k, 5)
      expect(s.ndim).to eq(1)
      expect(s.shape[0]).to eq(k)
      expect(u.ndim).to eq(2)
      expect(u.shape[0]).to eq(m)
      expect(u.shape[1]).to eq(k)
      expect(vt.ndim).to eq(2)
      expect(vt.shape[0]).to eq(k)
      expect(vt.shape[1]).to eq(n)
      expect((u.transpose.dot(u) - Numo::DFloat.eye(k)).abs.max).to be < 1e-8
      expect((vt.dot(vt.transpose) - Numo::DFloat.eye(k)).abs.max).to be < 1e-8
      expect((u.dot(s.diag.dot(vt)) - a).abs.max).to be < 1e-8
    end
  end
end
