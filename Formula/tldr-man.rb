class TldrMan < Formula
  include Language::Python::Virtualenv

  desc "Command-line TLDR client that displays tldr-pages as manpages"
  homepage "https://tldr-man.superatomic.dev"
  url "https://files.pythonhosted.org/packages/7d/9d/c5e871a176323956cbc1e3c94c9dd8f685d56edc2921f18b0c17abb42c75/tldr-man-1.0.2.tar.gz"
  sha256 "9e88b4b24a9b2ecf8efb46d07bc09547117ddfdcc0b02edec956a06de0bab27d"
  license "Apache-2.0"
  head "https://github.com/superatomic/tldr-man-client.git", branch: "main"

  depends_on "poetry" => :build
  depends_on "pandoc"
  depends_on "python@3.10"

  conflicts_with "homebrew/core/tldr", "homebrew/core/tealdeer", because: "both install `tldr` binaries"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/cc/85/319a8a684e8ac6d87a1193090e06b6bbb302717496380e225ee10487c888/certifi-2022.6.15.tar.gz"
    sha256 "84c85a9078b11105f04f3036a9482ae10e4621616db313fe045dd24743a0820d"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/93/1d/d9392056df6670ae2a29fcb04cfa5cee9f6fbde7311a1bb511d4115e9b7a/charset-normalizer-2.1.0.tar.gz"
    sha256 "575e708016ff3a5e3681541cb9d79312c416835686d054a23accb873b254f413"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/59/87/84326af34517fca8c58418d148f2403df25303e02736832403587318e9e8/click-8.1.3.tar.gz"
    sha256 "7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e"
  end

  resource "click-help-colors" do
    url "https://files.pythonhosted.org/packages/6c/c1/abc07420cfdc046c1005e16bc8090bc1f226d631b2bd172e5a8f5524c127/click-help-colors-0.9.1.tar.gz"
    sha256 "78cbcf30cfa81c5fc2a52f49220121e1a8190cd19197d9245997605d3405824d"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/62/08/e3fc7c8161090f742f504f40b1bccbfc544d4a4e09eb774bf40aafce5436/idna-3.3.tar.gz"
    sha256 "9d643ff0a55b762d5cdb124b8eaa99c66322e2157b69160bc32796e824360e6d"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a5/61/a867851fd5ab77277495a8709ddda0861b28163c4613b011bc00228cc724/requests-2.28.1.tar.gz"
    sha256 "7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/6d/d5/e8258b334c9eb8eb78e31be92ea0d5da83ddd9385dc967dd92737604d239/urllib3-1.26.11.tar.gz"
    sha256 "ea6e8fb210b19d950fab93b60c9009226c63a28808bc8386e05301e25883ac0a"
  end

  resource "xdg" do
    url "https://files.pythonhosted.org/packages/33/fe/67bc1f8ee2782bca3cdc63558a64f843bb9f88e15793475350809fbd8e01/xdg-5.1.1.tar.gz"
    sha256 "aa619f26ccec6088b2a6018721d4ee86e602099b24644a90a8d3308a25acd06c"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tldr --version")
  end
end
