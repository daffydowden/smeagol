#
# Cookbook Name:: ruby
# Recipe:: rbenv
#

DEFAULT_RUBY_VERSION = "1.9.2-p290"

root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'


homebrew "rbenv"
homebrew "ruby-build"

script "installing ruby-#{DEFAULT_RUBY_VERSION} to ~/Developer/.rbenv" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile

    if [ ! -d ~/Developer/.rbenv/versions/#{DEFAULT_RUBY_VERSION} ]; then
      ruby-build #{DEFAULT_RUBY_VERSION} ~/Developer/.rbenv/versions/#{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

script "installing ruby-1.8.7-p352 to ~/Developer/.rbenv" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile

    if [ ! -d ~/Developer/.rbenv/versions/1.8.7-p352 ]; then
      ruby-build 1.8.7-p352 ~/Developer/.rbenv/versions/1.8.7-p352
    fi
  EOS
  #rbenv install 1.8.7-p352
end

script "ensuring a default ruby is set" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    `which ruby | grep -q rbenv`
    if [ $? -ne 0 ]; then
      rbenv init
      rm -rf ~/.rbenv/versions
      ln -s ~/Developer/.rbenv/versions ~/.rbenv/versions
      rbenv rehash
      rbenv global #{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

homebrew "rbenv-gemset"

# execute "installing rbenv gemsets" do
#   command "rbenv gemset install"
# end

bash "installing basic gems" do
  gems = "rake rdoc bundler cinderella terminitor lunchy powify wirble hirb sketches what_methods map_by_method looksee net-http-spy jsonpretty awesome_print pry pry-doc pry-remote heroku engineyard gist"
  code <<-EOS
  source ~/.cinderella.profile
  gem install #{gems}
  rbenv rehash
  EOS
end
