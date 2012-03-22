require 'fileutils'

desc "Performs base installation"
task :speededit do

  # move around in a hurry
  system("git clone git://github.com/vim-scripts/camelcasemotion.git bundles/camelcasemotion")

  system("git clone git://github.com/scrooloose/nerdtree.git bundles/nerdtree")
  system("git clone https://github.com/majutsushi/tagbar.git bundles/tagbar")
  system("git clone git://github.com/jeetsukumaran/vim-buffergator.git bundles/buffergator")
  system("git clone git://github.com/tpope/vim-unimpaired.git bundles/unimpaired")

  system("git clone git://github.com/kien/ctrlp.vim.git bundles/ctrlp")
  system("git clone git://github.com/mileszs/ack.vim.git bundles/ack")
  system("git clone git://github.com/jeetsukumaran/vim-buffersaurus.git bundles/buffersaurus")
  system("git clone git://github.com/vim-scripts/IndexedSearch.git bundles/indexedsearch")
  system("git clone git://github.com/vim-scripts/matchit.zip.git bundles/matchit")

  # text editing speedup
  system("git clone git://github.com/yuriyvolkov/vim-snipmate.git bundles/snipmate")
  system("cd bundles/snipmate && git submodule init && git submodule update")
  system("git clone git://github.com/tpope/vim-surround.git bundles/surround")
  system("git clone git://github.com/tpope/vim-abolish.git bundles/abolish")
  system("git clone git://github.com/tpope/vim-repeat.git bundles/repeat")

  # code comments
  system("git clone git://github.com/scrooloose/nerdcommenter.git bundles/nerdcommenter")
  #system("git clone git://github.com/tomtom/tcomment_vim.git bundles/tcomment")
  #system("git clone git://github.com/tpope/vim-commentary.git bundles/commentary")

  # syntax checker
  system("git clone git://github.com/scrooloose/syntastic.git bundles/syntastic")

end

desc "Performs git plugins installation"
task :git do
  system("git clone git://github.com/tpope/vim-git.git bundles/git")
  system("git clone git://github.com/tpope/vim-fugitive.git bundles/fugitive")
  system("git clone git://github.com/int3/vim-extradite.git bundles/extradite")
end

desc "Performs ruby plugins installation"
task :ruby  do
  system("git clone git://github.com/vim-ruby/vim-ruby.git bundles/ruby")
  system("git clone git://github.com/tpope/vim-endwise.git bundles/endwise")
end

desc "Installs plugins for work with different markups"
task :markup do
  system("git clone git://github.com/tpope/vim-ragtag.git bundles/ragtag")
  system("git clone git://github.com/tpope/vim-haml.git bundles/haml")
  system("git clone git://github.com/groenewege/vim-less.git bundles/less")
  system("git clone https://github.com/ap/vim-css-color.git bundles/css-color")
end

desc "Installs plugins for rails development"
task :rails => [:ruby, :markup] do
  system("git clone git://github.com/tpope/vim-rails.git bundles/rails")
  system("git clone git://github.com/tpope/vim-cucumber.git bundles/cucumber")
end

desc "Installs plugin for sinatra developemtn"
task :sinatra => [:ruby, :markup] do
  system("git clone git://github.com/hallison/vim-ruby-sinatra.git bundles/sinatra")
end

desc "Performs webservices plugin installation"
task :ws do
  system("git clone git://github.com/tpope/vim-pastie.git bundles/pastie")
end

desc "Installs everything (dummy)"
task :install => [:speededit, :git, :rails] do
  system("git clone git://github.com/yuriyvolkov/vim-colorized.git bundles/vim-colorized")
  system("git clone git://github.com/millermedeiros/vim-statline.git bundles/vim-statline")
  system("git clone git://github.com/mikewest/vimroom.git bundles/vimroom")
end

desc "Performs bundles cleanup (delete plugins installed from git source)"
task :cleanup do
  path = File.join(File.dirname(__FILE__), 'bundles')
  Dir.foreach(path) do |entry|
    if File.exist?(File.join(path, entry, ".git"))
      FileUtils.rm_rf(File.join(path, entry))
    end unless entry =~ /\.+/
  end
end

desc "Performs plugins update"
task :update do
  path = File.join(File.dirname(__FILE__), 'bundles')
  Dir.foreach(path) do |entry|
    bundle = File.join(path, entry)
    if File.exist?(File.join(bundle, ".git"))
      print "Updating #{entry}: "
      system("cd #{bundle} && git pull")
      system("cd #{bundle} && git submodule update") unless `cd #{bundle} && git submodule`.empty?
    end unless entry =~ /\.+/
  end
end

desc "Performs all plugins installation"
task :default => :install

