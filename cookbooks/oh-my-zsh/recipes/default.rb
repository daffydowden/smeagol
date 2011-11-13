#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#

script "oh-my-zsh install from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    curl https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o - | sh
  EOS
end

template "#{ENV['HOME']}/.oh-my-zsh/custom/ip.plugins.zsh" do
  mode 0644
  owner ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "ip.plugin.zsh.erb"
end

template "#{ENV['HOME']}/.zshrc" do
  mode 0644
  owner ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "dot.zshrc.erb"
end

template "#{ENV['HOME']}/.zshenv" do
  mode 0644
  owner ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "dot.zshenv.erb"
end