require 'rails_helper'

describe ArticlesController do
  describe "GET /articles" do
    subject { get :index }

    let(:service) { double :service }
    let(:ids) { [1388505723, 1388892896, 1389126615] }
    let(:dir) { Pathname.new(Settings.article.path) }
    let(:paths) { ids.map { |id| dir.join("#{id}_a.md") } }
    let(:articles) { paths.map { |path| Article.new(path) } }

    before { paths.each { |path| File.write(path, "a") } }
    after { paths.each { |path| File.delete(path) } }

    before do
      expect(ArticleService).to receive(:new).and_return(service)
      expect(service).to receive(:search).and_return(articles)
    end

    it "responds 200 ok" do
      subject
      expect(response.status).to eq 200
    end

    it "renders index template" do
      subject
      expect(response).to render_template :index
    end

    it "assigns found articles to @articles" do
      subject
      expect(assigns[:articles]).to be articles
    end
  end

  describe "GET /articles/:id" do
    subject { get :show, id: "id" }

    let(:service) { double :service }

    before { expect(ArticleService).to receive(:new).and_return(service) }

    context "when article found" do
      let(:article) { {} }

      before { expect(service).to receive(:find).and_return(article) }

      it "responds 200 ok" do
        subject
        expect(response.status).to eq 200
      end

      it "renders show template" do
        subject
        expect(response).to render_template :show
      end

      it "assigns found article to @article" do
        subject
        expect(assigns[:article]).to be article
      end
    end

    context "when article not found" do
      before { expect(service).to receive(:find).and_raise(ResourceNotFound) }

      it "responds 404 not found" do
        subject
        expect(response.status).to eq 404
      end

      it "renders 404 error page" do
        subject
        expect(response).to render_template("shared/404")
      end
    end
  end
end
