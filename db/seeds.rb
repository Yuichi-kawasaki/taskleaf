User.create!(
  [
    {
      email: 'test@test.com',
      name: 'テスト',
      password: '11111111',
    },
    {
        email: "admin@admin.com",
        name:  "管理者",
        password:  "00000000",
        admin: true
      },
    ]
  )
