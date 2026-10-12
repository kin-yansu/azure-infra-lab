# azure-infra-lab

AzureのInfra確認用レポジトリ

バックエンドはFastAPIで構成する。起動手順は[backend/README.md](backend/README.md)、採用方針は[ADR-001](docs/adr/ADR-001-fastapi-backend.md)を参照。

## メモ

### やりたいこと

- デプロイスワップの動きと環境変数の確認
  - これはまずパブリックでアクセスできる状態で確認してもいいのでは？




| 確認箇所 | 今回の値 | 確認すること |
|---|---|---|
| `error` | `null` | 検証エラーがない |
| `resourceGroup` | `TestEnvironment` | 意図したリソースグループか |
| `validatedResources[].id` | 末尾が`storageAccounts/kinfatman0001toystorage` | 意図したリソース種類・名前か |
| `id` | `/subscriptions/d114…/resourceGroups/…` | 意図したサブスクリプションか |
