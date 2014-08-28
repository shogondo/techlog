require "rails_helper"

describe ArticleService do
  describe "#find" do
    subject { described_class.new.find(params) }

    let(:params) { ActionController::Parameters.new(data) }
    let(:data) { { id: id } }

    context "when article found" do
      let(:id) { 946652400 }
      let(:content) { "This is test content." }
      let(:path) { Pathname.new(Settings.article.path).join("#{id}_abc.md") }
      before { File.write(path, content) }
      after { File.delete path }
      it { is_expected.to be_a String }
      it { is_expected.to eq "<p>#{content}</p>" }
    end

    context "when id is nil" do
      let(:id) { nil }
      it { expect{subject}.to raise_error ResourceNotFound }
    end

    context "when id is not unix epoch" do
      let(:id) { "id" }
      it { expect{subject}.to raise_error ResourceNotFound }
    end

    context "when article not found" do
      let(:id) { 0 }
      it { expect{subject}.to raise_error ResourceNotFound }
    end
  end
end
