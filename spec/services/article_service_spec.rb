require "rails_helper"

describe ArticleService do
  describe "#find" do
    subject { described_class.new.find(params) }

    let(:params) { ActionController::Parameters.new(data) }
    let(:data) { { id: id } }

    context "when article found" do
      let(:id) { 946652400 }
      it { is_expected.to be_a String }
      it { is_expected.to eq "xxx" }
    end
  end
end
