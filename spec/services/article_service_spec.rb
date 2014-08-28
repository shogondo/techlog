require "rails_helper"

describe ArticleService do
  describe "#search" do
    subject { described_class.new.search(params) }

    let(:params) { ActionController::Parameters.new(data) }
    let(:data) { { } }

    context "when article found" do
      let(:ids) { [1388505723, 1388892896, 1389126615] }
      let(:dir) { Pathname.new(Settings.article.path) }
      let(:paths) { ids.map { |id| dir.join("#{id}_a.md") } }
      before { paths.each { |path| File.write(path, "a") } }
      after { paths.each { |path| File.delete(path) } }
      it { is_expected.to be_a Array }
      it { expect(subject.size).to eq 3 }
      it { expect(subject[0]).to be_a Article }
      it { expect(subject[1]).to be_a Article }
      it { expect(subject[2]).to be_a Article }
    end

    context "when article not found" do
      it { is_expected.to be_a Array }
      it { is_expected.to be_empty }
    end
  end

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
