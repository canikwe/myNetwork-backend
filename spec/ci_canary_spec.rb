# Temporary: proves the CI check fails when a spec fails (#43). Removed in the next commit.
RSpec.describe "CI canary" do
  it "fails on purpose" do
    expect(1).to eq(2)
  end
end
