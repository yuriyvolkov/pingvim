desc "Installs snipmate plugin and snippets"
task :snipmate do
  system("git clone git://github.com/yuriyvolkov/snipmate.vim.git bundles/snipmate")
  system("cd bundles/snipmate && git submodule init && git submodule update")
end

desc "Installs nerdtree plugin"
task :nerdtree do
  system("git clone git://github.com/scrooloose/nerdtree.git bundles/nerdtree")
end

desc "Installs nerdcommenter plugin"
task :nerdcommenter do
  system("git clone git://github.com/scrooloose/nerdcommenter.git bundles/nerdcommenter")
end

desc "Installs syntastic plugin"
task :syntastic do
  system("git clone git://github.com/scrooloose/syntastic.git bundles/syntastic")
end

desc "Installs endwise plugin"
task :endwise do
  system("git clone git://github.com/tpope/vim-endwise.git bundles/endwise")
end

desc "Installs surround plugin"
task :surround do
  system("git clone git://github.com/tpope/vim-surround.git bundles/surround")
end

desc "Installs unimpaired plugin"
task :unimpaired do
  system("git clone git://github.com/tpope/vim-unimpaired.git bundles/unimpaired")
end

desc "Installs ragtag (allml) plugin"
task :ragtag do
  system("git clone git://github.com/tpope/vim-ragtag.git bundles/ragtag")
end

desc "Installs pastie plugin"
task :pastie do
  system("git clone git://github.com/tpope/vim-pastie.git bundles/pastie")
end

desc "Installs vim-git plugin"
task :vim_git do
  system("git clone git://github.com/tpope/vim-git.git bundles/vim-git")
end

desc "Installs fugitive plugin"
task :fugitive do
  system("git clone git://github.com/tpope/vim-fugitive.git bundles/fugitive")
end

desc "Installs vim-ruby plugin"
task :vim_ruby do
  system("git clone git://github.com/vim-ruby/vim-ruby.git bundles/vim-ruby")
end

desc "Installs vim-rails plugin"
task :vim_rails do
  system("git clone git://github.com/tpope/vim-rails.git bundles/vim-rails")
end

desc "Installs vim-cucumber plugin"
task :vim_cucumber do
  system("git clone git://github.com/tpope/vim-cucumber.git bundles/vim-cucumber")
end

desc "Installs vim-haml plugin"
task :vim_haml do
  system("git clone git://github.com/tpope/vim-haml.git bundles/vim-haml")
end

desc "Performs default installation"
task :default => [:snipmate, :nerdtree, :syntastic, :endwise, :surround, :unimparied, :pastie, :vim_git, :fugitive]

desc "Performs installation for rails development"
task :rails => [:default, :ragtag, :vim_ruby, :vim_rails, :vim_cucumber, :vim_haml]

