## Setup Environment
1. Install Ruby 2.7.1

```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.7.1
rbenv global 2.7.1
ruby -v
gem install bundler
```
2. Install Rails 6
```
gem install rails -v 6.0.3.4
rbenv rehash
rails -v
```
3. Pull source code
4. Setup
```
bundle install
rails db:create
rails db:migrate
rails db:seed
```
5. Run server
```
rails s
```
*Install DB browser and open file db/development.sqlite3 to vizualizare data*
