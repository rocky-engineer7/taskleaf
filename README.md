# Taskleaf Rails アプリケーション

## 開発環境

- Ruby 3.2.3
- Rails 7.0.8.1
- PostgreSQL 14.5
- Redis 7.2.4
- Node.js 18.19.0
- Yarn 1.22.22
- Docker
- Docker Compose

## 前提条件

- Docker 及び Docker Compose がインストールされている
- Git がインストールされている

## 手順

1. **プロジェクトのクローン**

```
git clone https://github.com/your-username/taskleaf.git
cd taskleaf
```

2. **Docker Compose によるビルドと起動**

```
docker compose up -d --build
```

これにより、Dockerfile と docker-compose.yml に基づいてコンテナがバックグラウンドでビルドされ、起動します。

3. **データベースの作成**

```
docker compose exec web rails db:create
```

4. **マイグレーションの実行**

```
docker compose exec web rails db:migrate
```

5. **アセットのプリコンパイル**

```
docker compose exec web rails assets:precompile
```

6. **管理者ユーザーの作成**

```
docker compose exec web rails console
```

コンソール内で以下のコマンドを実行します。

```ruby
user = User.new(name: "admin", email: "admin@example.com", password: "password", admin: true)
user.save
```

これで、Rails アプリケーションが適切に立ち上がり、ブラウザから `http://localhost:3000` にアクセスできるようになります。

## 仕様

- 管理者権限（admin）を持つユーザーは、他のユーザーの作成、読み込み、編集、削除ができます。
- 管理者権限の有無に関係なく、全てのユーザーがタスクの CRUD 操作（作成、読み込み、更新、削除）を行えます。
- エクスポート機能により、現在のタスクを CSV 形式でダウンロードできます。ダウンロードしたファイルは、表計算ソフト（Numbers や Excel など）で開くことができます。
- インポート機能により、CSV ファイルからタスクを追加できます。CSV ファイルのフォーマットは以下の通りです。
  - 列: name, description, user_id, created_at, updated_at
  - 例:
    ```csv
    タスク1,タスク1の説明,1,2023-06-01 10:00:00,2023-06-01 10:00:00
    タスク2,タスク2の説明,1,2023-06-02 11:00:00,2023-06-02 11:00:00
    タスク3,タスク3の説明,2,2023-06-03 12:00:00,2023-06-03 12:00:00
    タスク4,タスク4の説明,2,2023-06-04 13:00:00,2023-06-04 13:00:00
    タスク5,タスク5の説明,1,2023-06-05 14:00:00,2023-06-05 14:00:00
    ```
- タスクに画像を添付することができます。

## トラブルシューティング

### コンテナの起動に関するエラー

`docker compose up -d --build`の実行時にエラーが発生した場合は、エラーメッセージを確認し、適切な対処を行ってください。必要に応じて、`docker compose down`を実行してコンテナを停止・削除し、再度`docker compose up -d --build`を実行してみてください。

### その他のエラー

その他のエラーが発生した場合は、ログを確認し、適切な対処を行ってください。必要に応じて、`docker compose down`を実行し、コンテナを停止・削除してから、手順を最初から実行してみてください。
