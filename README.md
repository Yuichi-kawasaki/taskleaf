# README
1,model:tasks
● description
  ■ text

    ● timestamps

2,User
    ● name
      ■ string

    ● email
      ■ string

    ● password_digest
      ■ string

    ● timestamps
>>>>>>> f4627c44a78d5ae8d4d4f0604f869c2a85e7796c


『heroku デプロイ方法』

rails assets:precompile RAILS_ENV=production　（アセットプリコンパイル）

git add -A

git commit -m "init"

heroku create (初回のみ)

git push heroku master

heroku run rails db:migrate
