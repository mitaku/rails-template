# -*- coding: utf-8 -*-
#### Rails Template
###
##
#
#
##
###
####

#coding:utf-8
puts 'make auth functions through bored routine by using rails3 template.'

remove_file ".gitignore"
file ".gitignore", <<-END
.bundle
.rvmrc
.rspec
log/*.log
*.swp
*.swo
.sass-cache
*~
*.cache
*.log
*.pid
tmp/**/*
db/*.sqlite3
config/database.yml
db/schema.rb
vendor/bundle
END

#----------------------------------------------------------------------------
# 不要なファイルの削除
#----------------------------------------------------------------------------
puts 'delete needless files'

%w{ public/index.html public/favicon.ico app/assets/images/rails.png README }.each do |file|
  remove_file file
end

#----------------------------------------------------------------------------
# 環境依存ファイルの移動
#----------------------------------------------------------------------------
run "cp config/database.yml config/database.yml.example"

#----------------------------------------------------------------------------
# Gemfile の設定
#----------------------------------------------------------------------------
puts 'Setting for Gemfile'

remove_file "Gemfile"
create_file 'Gemfile', "source 'http://rubygems.org'\n"
gem 'rails', '3.1.0.rc6'

gem 'sqlite3'

gem 'sass-rails', "~> 3.1.0.rc", :group => :assets
gem 'coffee-rails', "~> 3.1.0.rc", :group => :assets
gem 'uglifier', :group => :assets

gem "rspec-rails", :group => [ :development, :test ]
gem 'jquery-rails'
gem 'pry', :group => :development
gem 'twitter-bootstrap-rails', "0.0.3"
gem 'haml-rails'
gem 'devise'
gem 'formtastic', "~> 2.0.0.rc"
#毎回入れる gem はここに追加すればよし。

# #----------------------------------------------------------------------------
# # Bundler を使ってインストール
# #----------------------------------------------------------------------------
puts 'install gems (Please wait...)'
run 'bundle install --path vendor/bundle'

# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "Install gems with Bundler into vendor/bundle."'
# end


# #----------------------------------------------------------------------------
# # Generate
# #----------------------------------------------------------------------------
puts 'Generate'
generate 'jquery:install --ui'
generate 'rspec:install'
generate 'formtastic:install'

# #----------------------------------------------------------------------------
# # ホーム画面の作成とビューの作成・ルーティングの設定
# #----------------------------------------------------------------------------
# puts 'generate Home controller and view'

# run 'rails g controller home index'

# puts 'set home view to root'

# inject_into_file 'config/routes.rb', :after => "::Application.routes.draw do\n" do
# <<-RUBY
#   root :to => "home#index"
# RUBY
# end


# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "create Home controller and view and routing"'
# end

# #----------------------------------------------------------------------------
# # Devise のインストール
# #----------------------------------------------------------------------------
# puts 'install Devise'

# run 'rails g devise:install'

# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "install Devise"'
# end

# #----------------------------------------------------------------------------
# # インストール時に指定される設定の1,3を実行(2のhome#indexは既に完)
# #----------------------------------------------------------------------------
# puts 'modify views and setting of mailer'

# inject_into_file 'app/views/layouts/application.html.erb', :after => "<body>\n" do
# <<-RUBY
# <p style="color: green"><%= notice %></p>
# <p style="color: red"><%= alert %></p>
# RUBY
# end

# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "modify view to render notice and alert"'
# end

# #メール設定
# #development環境ではサーバーのログにメール内容出ます。
# inject_into_file 'config/environments/development.rb', :after => "config.action_dispatch.best_standards_support = :builtin\n" do
# <<-RUBY
# 	config.action_mailer.default_url_options = { :host => 'localhost:3000' }
# RUBY
# end

# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "modify for Mailer"'
# end

# #----------------------------------------------------------------------------
# # Userモデルの生成と設定
# #----------------------------------------------------------------------------
# puts 'generate User model and modify migration file'

# run 'rails g devise User'
# run 'rm app/models/user.rb'

# #:token_authenticatable, :timeoutable 以外を使うようにします。必要に応じて修正して下さい。

# create_file 'app/models/user.rb' do
# <<-RUBY
# class User < ActiveRecord::Base
#   # Include default devise modules. Others available are:
#   # :token_authenticatable, :confirmable, :lockable and :timeoutable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :trackable, :validatable,
# 				 :confirmable, :lockable

#   # Setup accessible (or protected) attributes for your model
#   attr_accessible :email, :password, :password_confirmation, :remember_me
# end
# RUBY
# end

# #User 用の migrate ファイルの修正
# first_migrate_file_name = Dir::glob("db/migrate/*_devise_create_users.rb").first

# inject_into_file first_migrate_file_name, :after => "# t.token_authenticatable\n" do
# <<-RUBY
#       t.confirmable
#       t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
# RUBY
# end

# inject_into_file first_migrate_file_name, :after => "# add_index :users, :unlock_token,         :unique => true\n" do
# <<-RUBY
#     add_index :users, :confirmation_token,   :unique => true
#     add_index :users, :unlock_token,         :unique => true
# RUBY
# end

# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "generate and modify for User model and it\'s migration"'
# end


# #----------------------------------------------------------------------------
# # application.cssの作成
# #----------------------------------------------------------------------------
remove_file "app/assets/stylesheets/application.css"
create_file "app/assets/stylesheets/application.css" do
<<-FILE
/*
 * This is a manifest file that'll automatically include all the stylesheets available in this directory
 * and any sub-directories. You're free to add application-wide styles to this file and they'll appear at
 * the top of the compiled file, but it's generally better to create a new file per style scope.
 *= require_self
 * Twitter Bootstrap
 *= require bootstrap-1.0.0.min
 # app/assets/stylesheets/application.css
 *= require formtastic
 *= require my_formtastic_changes

 # app/assets/stylesheets/ie6.css
 *= require formtastic_ie6

 # app/assets/stylesheets/ie7.css
 *= require formtastic_ie7

 *= require_tree .
*/

FILE
end

# #----------------------------------------------------------------------------
# # View の生成と Home画面の作成
# #----------------------------------------------------------------------------
# puts 'generate views'
# run 'rails generate devise:views'

# puts 'add functional links to Home view'

# run 'rm app/views/home/index.html.erb'
# create_file 'app/views/home/index.html.erb' do <<-FILE
# <h1>HOME 画面</h1>
# <%= user_signed_in? ? current_user.email : 'ゲスト'%>さん。<br />
# <% if user_signed_in? %>
# <%= link_to 'パスワードの変更', edit_user_registration_path %>
# <%= link_to 'ログアウト', destroy_user_session_path %>
# <% else %>
# <%= link_to '新規登録', new_user_registration_path %>　
# <%= link_to 'ログイン', new_user_session_path %>
# <% end %>
# <br />
# <p>便利な改造してくれたら、リンク貼らせて欲しいから教えてね！<br />
# → <a href="http://twitter.com/usagee_jp">@usagee_jp</a></p>
# FILE
# end

# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "modify Home view"'
# end


# #----------------------------------------------------------------------------
# # 日本語化ファイルのインストールと設定
# #----------------------------------------------------------------------------
# puts 'install Japanese translate files'

# proxy_host, proxy_port = (ENV["HTTP_PROXY"] || '').sub(/http:\/\//, '').split(':')

# # Atsushi Nakatsugawa さんの devise.ja.yml をDL します。 皆で褒めたたえましょう。
# require 'open-uri'

# open("config/locales/devise.ja.yml", "wb") do |output|
#   open("http://gitorious.org/~moongift/shapado/qahubjp/blobs/raw/35fd7dd18397f0b32dd76023029d10807726881e/config/locales/devise/devise.ja.yml") do |data|
#     output.write(data.read)
#   end
# end

# # kuroda さんの ja.yml をDL します。 皆で崇めましょう。

# require 'net/http'
# require 'net/https'

# uri = URI.parse("https://github.com/svenfuchs/rails-i18n/raw/master/rails/locale/ja.yml")
# http = Net::HTTP::Proxy(proxy_host, proxy_port).new(uri.host, 443)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE
# request = Net::HTTP::Get.new(uri.request_uri)
# response = http.request(request)
# response.body

# open("config/locales/ja.yml", "wb") do |output| output.write(response.body) end




# # デフォルトの言語を変更します。
# inject_into_file "config/application.rb", :after => "# config.i18n.default_locale = :de\n" do
# <<-RUBY
# 		config.i18n.default_locale = :ja
# RUBY
# end

# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "install files for Japanese"'
# end


# #----------------------------------------------------------------------------
# # 日本語化の残り
# #----------------------------------------------------------------------------
# puts 'modify other for Japanese translation'

# create_file 'config/locales/devise.attributes.ja.yml' do
# <<-YML
# ja:
#   activerecord:
#     attributes:
#       user:
#         email: "メールアドレス"
#         password: "パスワード"
#         password_confirmation: "パスワードの確認"
#         current_password: "現在のパスワード"
# YML
# end

# #----------------------------------------------------------------------------
# # confirmations の日本語化
# #----------------------------------------------------------------------------
# run 'rm app/views/devise/confirmations/new.html.erb'
# create_file 'app/views/devise/confirmations/new.html.erb' do
# <<-ERB
# <h2>登録確認メールが届きませんか？</h2>

# <%= form_for(resource, :as => resource_name, :url => confirmation_path(resource_name), :html => { :method => :post }) do |f| %>
#   <%= devise_error_messages! %>

#   <p><%= f.label :email %><br />
#   <%= f.text_field :email %></p>

#   <p><%= f.submit "登録確認メールの再送信" %></p>
# <% end %>

# <%= render :partial => "devise/shared/links" %>
# ERB
# end
# #----------------------------------------------------------------------------
# # confirmations の日本語化
# #----------------------------------------------------------------------------
# run 'rm app/views/devise/confirmations/new.html.erb'
# create_file 'app/views/devise/confirmations/new.html.erb' do
# <<-ERB
# <h2>登録確認メールが届きませんか？</h2>

# <%= form_for(resource, :as => resource_name, :url => confirmation_path(resource_name), :html => { :method => :post }) do |f| %>
#   <%= devise_error_messages! %>

#   <p><%= f.label :email %><br />
#   <%= f.text_field :email %></p>

#   <p><%= f.submit "登録確認メールの再送信" %></p>
# <% end %>

# <%= render :partial => "devise/shared/links" %>
# ERB
# end
# #----------------------------------------------------------------------------
# # mailer の日本語化（develop環境で確認時日本語だと面倒なので省略。）
# #----------------------------------------------------------------------------
# run 'rm app/views/devise/mailer/confirmation_instructions.html.erb'
# create_file 'app/views/devise/mailer/confirmation_instructions.html.erb' do
# <<-ERB
# <p>Welcome <%= @resource.email %>!</p>

# <p>You can confirm your account through the link below:</p>

# <p><%= link_to 'Confirm my account', confirmation_url(@resource, :confirmation_token => @resource.confirmation_token) %></p>

# ERB
# end

# run 'rm app/views/devise/mailer/reset_password_instructions.html.erb'
# create_file 'app/views/devise/mailer/reset_password_instructions.html.erb' do
# <<-ERB
# <p>Hello <%= @resource.email %>!</p>

# <p>Someone has requested a link to change your password, and you can do this through the link below.</p>

# <p><%= link_to 'Change my password', edit_password_url(@resource, :reset_password_token => @resource.reset_password_token) %></p>

# <p>If you didn't request this, please ignore this email.</p>
# <p>Your password won't change until you access the link above and create a new one.</p>

# ERB
# end

# run 'rm app/views/devise/mailer/unlock_instructions.html.erb'
# create_file 'app/views/devise/mailer/unlock_instructions.html.erb' do
# <<-ERB
# <p>Hello <%= @resource.email %>!</p>

# <p>Your account has been locked due to an excessive amount of unsuccessful sign in attempts.</p>

# <p>Click the link below to unlock your account:</p>

# <p><%= link_to 'Unlock my account', unlock_url(@resource, :unlock_token => @resource.unlock_token) %></p>

# ERB
# end
# #----------------------------------------------------------------------------
# # passwords の日本語化
# #----------------------------------------------------------------------------
# run 'rm app/views/devise/passwords/new.html.erb'
# create_file 'app/views/devise/passwords/new.html.erb' do
# <<-ERB
# <h2>パスワードを忘れてしまいましたか？</h2>

# <%= form_for(resource, :as => resource_name, :url => password_path(resource_name), :html => { :method => :post }) do |f| %>
#   <%= devise_error_messages! %>

#   <p><%= f.label :email %><br />
#   <%= f.text_field :email %></p>

#   <p><%= f.submit "パスワードのリセット" %></p>
# <% end %>

# <%= render :partial => "devise/shared/links" %>
# ERB
# end

# run 'rm app/views/devise/passwords/edit.html.erb'
# create_file 'app/views/devise/passwords/edit.html.erb' do
# <<-ERB
# <h2>パスワードの変更</h2>

# <%= form_for(resource, :as => resource_name, :url => password_path(resource_name), :html => { :method => :put }) do |f| %>
#   <%= devise_error_messages! %>
#   <%= f.hidden_field :reset_password_token %>

#   <p><%= f.label :password, '新しいパスワード' %><br />
#   <%= f.password_field :password %></p>

#   <p><%= f.label :password_confirmation, '新しいパスワードの確認' %><br />
#   <%= f.password_field :password_confirmation %></p>

#   <p><%= f.submit "パスワードの変更" %></p>
# <% end %>

# <%= render :partial => "devise/shared/links" %>
# ERB
# end

# #----------------------------------------------------------------------------
# # registrations の日本語化
# #----------------------------------------------------------------------------
# run 'rm app/views/devise/registrations/new.html.erb'
# create_file 'app/views/devise/registrations/new.html.erb' do
# <<-ERB
# <h2>新規登録</h2>

# <%= form_for(resource, :as => resource_name, :url => registration_path(resource_name)) do |f| %>
#   <%= devise_error_messages! %>

#   <p><%= f.label :email %><br />
#   <%= f.text_field :email %></p>

#   <p><%= f.label :password %><br />
#   <%= f.password_field :password %></p>

#   <p><%= f.label :password_confirmation %><br />
#   <%= f.password_field :password_confirmation %></p>

#   <p><%= f.submit "登録" %></p>
# <% end %>

# <%= render :partial => "devise/shared/links" %>

# ERB
# end

# run 'rm app/views/devise/registrations/edit.html.erb'
# create_file 'app/views/devise/registrations/edit.html.erb' do
# <<-ERB
# <h2><%= resource_name.to_s.humanize %> の編集</h2>

# <%= form_for(resource, :as => resource_name, :url => registration_path(resource_name), :html => { :method => :put }) do |f| %>
#   <%= devise_error_messages! %>

#   <p><%= f.label :email %><br />
#   <%= f.text_field :email %></p>

#   <p><%= f.label :password, '新しいパスワード' %> <i>(変更したくない場合は空白のままで)</i><br />
#   <%= f.password_field :password %></p>

#   <p><%= f.label :password_confirmation, '新しいパスワードの確認' %><br />
#   <%= f.password_field :password_confirmation %></p>

#   <p><%= f.label :current_password %> <i>(変更を有効にするために必要です。)</i><br />
#   <%= f.password_field :current_password %></p>

#   <p><%= f.submit "更新" %></p>
# <% end %>

# <h3>退会</h3>

# <p><%= link_to "退会する", registration_path(resource_name), :confirm => "本当に退会してよろしいですか？", :method => :delete %></p>

# <%= link_to "Back", :back %>
# ERB
# end

# #----------------------------------------------------------------------------
# # sessions の日本語化
# #----------------------------------------------------------------------------
# run 'rm app/views/devise/sessions/new.html.erb'
# create_file 'app/views/devise/sessions/new.html.erb' do
# <<-ERB
# <h2>ログイン</h2>

# <%= form_for(resource, :as => resource_name, :url => session_path(resource_name)) do |f| %>
#   <p><%= f.label :email %><br />
#   <%= f.text_field :email %></p>

#   <p><%= f.label :password %><br />
#   <%= f.password_field :password %></p>

#   <% if devise_mapping.rememberable? -%>
#     <p><%= f.check_box :remember_me %> <%= f.label :remember_me, 'ログイン状態を保持する' %></p>
#   <% end -%>

#   <p><%= f.submit "ログイン" %></p>
# <% end %>

# <%= render :partial => "devise/shared/links" %>

# ERB
# end


# #----------------------------------------------------------------------------
# # shared の日本語化
# #----------------------------------------------------------------------------
# run 'rm app/views/devise/shared/_links.erb'
# create_file 'app/views/devise/shared/_links.erb' do
# <<-ERB
# <%- if controller_name != 'sessions' %>
#   <%= link_to "ログイン", new_session_path(resource_name) %><br />
# <% end -%>

# <%- if devise_mapping.registerable? && controller_name != 'registrations' %>
#   <%= link_to "新規登録", new_registration_path(resource_name) %><br />
# <% end -%>

# <%- if devise_mapping.recoverable? && controller_name != 'passwords' %>
#   <%= link_to "パスワードを忘れてしまいましたか？", new_password_path(resource_name) %><br />
# <% end -%>

# <%- if devise_mapping.confirmable? && controller_name != 'confirmations' %>
#   <%= link_to "登録確認メールが届きませんか？", new_confirmation_path(resource_name) %><br />
# <% end -%>

# <%- if devise_mapping.lockable? && resource_class.unlock_strategy_enabled?(:email) && controller_name != 'unlocks' %>
#   <%= link_to "アカウントのロック解除メールの再送信", new_unlock_path(resource_name) %><br />
# <% end -%>

# ERB
# end
# #----------------------------------------------------------------------------
# # unlocks の日本語化
# #----------------------------------------------------------------------------
# run 'rm app/views/devise/unlocks/new.html.erb'
# create_file 'app/views/devise/unlocks/new.html.erb' do
# <<-ERB
# <h2>アカウントのロック解除メールの再送信</h2>

# <%= form_for(resource, :as => resource_name, :url => unlock_path(resource_name), :html => { :method => :post }) do |f| %>
#   <%= devise_error_messages! %>

#   <p><%= f.label :email %><br />
#   <%= f.text_field :email %></p>

#   <p><%= f.submit "ロック解除メールの再送信" %></p>
# <% end %>

# <%= render :partial => "devise/shared/links" %>
# ERB
# end


# if git_flag
# 	git :add => '-A'
# 	git :commit => '-m "set devise.attributes.ja.yml and modify Views"'
# end

# #----------------------------------------------------------------------------
# # データベースの設定（SQLite使う人は触らなくてOK）
# #----------------------------------------------------------------------------
# =begin

# run 'rm config/database.yml'
# create_file 'config/database.yml' do <<-FILE
# # SQLite version 3.x
# #   gem install sqlite3-ruby (not necessary on OS X Leopard)
# development:
#   adapter: sqlite3
#   database: db/development.sqlite3
#   pool: 5
#   timeout: 5000

# # Warning: The database defined as "test" will be erased and
# # re-generated from your development database when you run "rake".
# # Do not set this db to the same as development or production.
# test:
#   adapter: sqlite3
#   database: db/test.sqlite3
#   pool: 5
#   timeout: 5000

# production:
#   adapter: mysql
#   database: huga_production
#   username: hoge
#   password: hige
#   socket: /tmp/mysql.sock
#   encoding: utf8
#   host: mysql.hoge.com

# FILE
# end

# =end
# #----------------------------------------------------------------------------
# # データベースの作成
# #----------------------------------------------------------------------------

# run 'rake db:migrate'

# #----------------------------------------------------------------------------
# # サーバーの起動（今回はメールでの確認があるのでログ確認が必要なのでコメントアウト）
# #----------------------------------------------------------------------------
# #run 'rails server'
