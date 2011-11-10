#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#

script "pow install from pow.cx" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    curl get.pow.cx | sh
  EOS
end
