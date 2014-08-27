require 'rails_helper'

describe ArticlesController do
  describe "GET /articles/:id" do
    subject { get :show, id: "id" }

    let(:service) { double :service }

    before { expect(ArticleService).to receive(:new).and_return(service) }

    context "when article found" do
      let(:content) { {} }

      before { expect(service).to receive(:find).and_return(content) }

      it "responds 200 ok" do
        subject
        expect(response.status).to eq 200
      end

      it "renders show template" do
        subject
        expect(response).to render_template :show
      end

      it "assigns found article to @content" do
        subject
        expect(assigns[:content]).to be content
      end
    end

    context "when article not found" do
      let(:content) { {} }

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
