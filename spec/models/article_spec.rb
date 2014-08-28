require "rails_helper"

describe Article do
  describe "#html" do
    subject { article.html }

    let(:article) { described_class.new }

    context "when content is presented" do
      before { article.content = "# a\nb" }
      it { is_expected.to eq "<h1>a</h1>\n\n<p>b</p>" }
    end

    context "when content is nil" do
      it { is_expected.to be_nil }
    end
  end
end
