require 'rails_helper'

describe HtmlSanitizer do
  it ".no_html" do
    string = "<div class='wtf'>stuff</div>"
    clean = HtmlSanitizer.no_html(string)

    expect(clean).to eq("stuff")
  end
end
