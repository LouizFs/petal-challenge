require 'rails_helper'

shared_examples_for "unauthorized" do
  it 'should return unauthorized response' do
    request.headers["Authorization"] = "token wrong"

    subject

    expect(response).to have_http_status(:unauthorized)
  end
end
