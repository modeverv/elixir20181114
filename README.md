# VueSample

* api https://qiita.com/piacere_ex/items/50d847170291c41fef64
* graphql https://qiita.com/piacere_ex/items/b4f57b55663403f9ec8e


## TODO

### ユーザー認証 [sssss](https://www.one-tab.com/page/pTy8f1UfQS2k2eHBHGiSWg)



### 静的ファイル

`priv/static`にあるのでリバースプロキシでどうにかすれば。

### belongs_toなど

Railsでいうところのオールインワンな概念は無いのかな。  
https://kazucocoa.wordpress.com/2015/07/24/elixirphoenixhas_one%E3%82%84belongs_to%E3%81%AE%E9%96%A2%E4%BF%82%E3%81%AB%E3%81%82%E3%82%8B%E3%83%A2%E3%83%87%E3%83%AB%E3%82%92%E3%80%81%E4%BB%96%E6%96%B9%E3%81%AE%E3%83%A2%E3%83%87%E3%83%AB/  
否、あるっぽい
https://stackoverflow.com/questions/34184571/how-to-get-the-belongs-to-association-with-ecto-in-elixir  

#### blongs_to
https://hexdocs.pm/ecto/Ecto.Schema.html#belongs_to/3  

```
defmodule Comment do
  use Ecto.Schema

  schema "comments" do
    belongs_to :post, Post
  end
end

# The post can come preloaded on the comment record
[comment] = Repo.all(from(c in Comment, where: c.id == 42, preload: :post))
comment.post #=> %Post{...}
```

#### has_many

https://hexdocs.pm/ecto/Ecto.Schema.html#has_many/3  

```
defmodule Post do
  use Ecto.Schema
  schema "posts" do
    has_many :comments, Comment
  end
end

# Get all comments for a given post
post = Repo.get(Post, 42)
comments = Repo.all assoc(post, :comments)

# The comments can come preloaded on the post struct
[post] = Repo.all(from(p in Post, where: p.id == 42, preload: :comments))
post.comments #=> [%Comment{...}, ...]
```

#### qiita

https://qiita.com/yoavlt/items/ffbda1f0397839c5db99

この記事が良さそう
https://qiita.com/techno-tanoC/items/c703a5a90e4133fbea82

### バッチ

バッチはコントローラーに認証つけて実装してやればよいのかもしれない。
GenServerを使ってバックグラウンドで実行する方法などが簡易かも
Sidekiqっぽいのもあるらしい。必要になれば。
sidekiqしんどいな。。
https://medium.com/@cschneid/background-jobs-in-elixir-phoenix-60dddf4ce207


### プロダクション起動
https://hexdocs.pm/phoenix/deployment.html

```
# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
cd assets && webpack --mode production && cd ..

mix phx.digest

# Custom tasks (like DB migrations)
MIX_ENV=prod mix ecto.migrate

# Finally run the server
PORT=4001 MIX_ENV=prod mix phx.server
```


## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

