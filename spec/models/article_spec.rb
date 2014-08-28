require "rails_helper"

describe Article do
  describe "#new" do
    subject { described_class.new(path) }

    context "when path found" do
      let(:path) { Pathname.new(Settings.article.path).join("0_abc.md") }
      before { File.write(path, "content") }
      after { File.delete path }
      it { is_expected.to be_a described_class }
    end

    context "when path not found" do
      let(:path) { Pathname.new(Settings.article.path).join("0_abc.md") }
      it { expect{subject}.to raise_error }
    end

    context "when path is nil" do
      let(:path) { nil }
      it { expect{subject}.to raise_error }
    end
  end

  describe "#content" do
    subject { article.content }

    let(:article) { described_class.new(path) }
    let(:path) { Pathname.new(Settings.article.path).join("0_abc.md") }

    before { File.write(path, "# head\nbody") }
    after { File.delete path }

    it { is_expected.to eq "# head\nbody" }
  end

  describe "#html" do
    subject { article.html }

    let(:article) { described_class.new(path) }
    let(:path) { Pathname.new(Settings.article.path).join("0_abc.md") }

    context "when content is presented" do
      before { File.write(path, "# head\nbody") }
      after { File.delete path }
      it { is_expected.to eq "<h1>head</h1>\n\n<p>body</p>" }
    end

    context "when content is empty" do
      before { File.write(path, "") }
      after { File.delete path }
      it { is_expected.to be_nil }
    end
  end

  describe "#title" do
    subject { article.title }

    let(:article) { described_class.new(path) }
    let(:path) { Pathname.new(Settings.article.path).join("0_abc.md") }

    context "when content is presented" do
      before { File.write(path, "# head\nbody") }
      after { File.delete path }
      it { is_expected.to eq "head" }
    end

    context "when content is empty" do
      before { File.write(path, "") }
      after { File.delete path }
      it { is_expected.to be_nil }
    end
  end

  describe "#created_at" do
    subject { article.created_at }

    let(:article) { described_class.new(path) }
    let(:dir) { Pathname.new(Settings.article.path) }

    before { File.write(path, "# head\nbody") }
    after { File.delete path }

    context "when filename is valid format" do
      let(:path) { dir.join("1388502000_a.md") }
      it { is_expected.to eq Time.zone.at(1388502000) }
    end

    context "when filename is invalid format" do
      let(:path) { dir.join("a_a.md") }
      it { is_expected.to be_nil }
    end
  end
end
