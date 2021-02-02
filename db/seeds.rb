users = User.create(
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
      {
        email: 'test2@test2.com',
        name: 'テスト2',
        password: '22222222',
      },
      {
        email: "test3@test3.com",
        name:  "テスト3",
        password:  "33333333",
      },
      {
        email: 'test4@test4.com',
        name: 'テスト4',
        password: '44444444',
      },
      {
        email: "test5@test5.com",
        name:  "テスト5",
        password:  "55555555",
      },
      {
        email: 'test6@test6.com',
        name: 'テスト6',
        password: '66666666',
      },
      {
        email: "test7@test7.com",
        name:  "テスト7",
        password:  "77777777",
      },
      {
        email: 'test8@test8.com',
        name: 'テスト8',
        password: '88888888',
      },
      {
        email: "test9@test9.com",
        name:  "テスト9",
        password:  "99999999",
      }
    ]
  )

  Label.create(title:'新規' )
  Label.create(title:'リピート' )
  Label.create(title:'修理' )
  Label.create(title:'返品' )
  Label.create(title:'追加' )
  Label.create(title:'部品' )
  Label.create(title:'転送' )
  Label.create(title:'値引' )
  Label.create(title:'現地確認' )
  Label.create(title:'危険物' )


  Task.create!(
    [
      {
        name: 'ドライポンプ',
        limit_on: '2020-01-01',
        status: '未着手',
        priority: '低',
        user_id: users[0].id
      },
      {
        name: 'ターボ分子ポンプ',
        limit_on: '2020-02-02',
        status: '未着手',
        priority: '中',
        user_id: users[1].id
      },
      {
        name: '油回転真空ポンプ',
        limit_on: '2020-03-03',
        status: '着手中',
        priority: '高',
        user_id: users[2].id
      },
      {
        name: 'メカニカルプースターポンプ',
        limit_on: '2020-04-04',
        status: '完了',
        priority: '低',
        user_id: users[3].id
      },
      {
        name: 'クライオポンプ',
        limit_on: '2020-05-05',
        status: '着手中',
        priority: '中',
        user_id: users[1].id
      },
      {
        name: 'スパッタイオンポンプ',
        limit_on: '2020-06-06',
        status: '着手中',
        priority: '高',
        user_id: users[0].id
      },
      {
        name: '電離真空系',
        limit_on: '2020-07-07',
        status: '未着手',
        priority: '低',
        user_id: users[7].id
      },
      {
        name: 'ピラニ真空系',
        limit_on: '2020-08-08',
        status: '完了',
        priority: '中',
        user_id: users[5].id
      },
      {
        name: '蒸着装置',
        limit_on: '2020-09-09',
        status: '未着手',
        priority: '高',
        user_id: users[8].id
      },
      {
        name: 'スパッタ装置',
        limit_on: '2020-10-10',
        status: '着手中',
        priority: '高',
        user_id: users[0].id
      }
    ]
  )
