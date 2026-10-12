# ADR-000 Bicepのトレーニング

## ステータス

完了

## コンテキスト・文脈・背景

まずはBicepのトレーニングとしてストレージアカウントを作成するサンプルコードを作成する。

## 実施するコマンド

```bash
az login

az account list --output table

az account set --subscription "サブスクリプション名"

az account show --output table

```

```bash
az stack group validate \
  --name "$stack_name" \
  --resource-group "$rg_name" \
  --template-file ./main.bicep \
  --action-on-unmanage detachAll \
  --deny-settings-mode none
```

- デプロイスタックでデプロイ

```bash
az stack group create \
  --name "$stack_name" \
  --resource-group "$rg_name" \
  --template-file ./main.bicep \
  --action-on-unmanage detachAll \
  --deny-settings-mode none

```


## 確認ポイント


| 確認箇所 | 今回の値 | 確認すること |
|---|---|---|
| `error` | `null` | 検証エラーがない |
| `resourceGroup` | `TestEnvironment` | 意図したリソースグループか |
| `validatedResources[].id` | 末尾が`storageAccounts/kinfatman0001toystorage` | 意図したリソース種類・名前か |
| `id` | `/subscriptions/d114…/resourceGroups/…` | 意図したサブスクリプションか |



## 結果・影響

- 継続的に機能追加する
- 設計判断はADRとして残す
- コード、テスト、ドキュメントを同等に扱う

## 重要な注意点

アーキテクチャに影響する変更については、実装前にADRを作成すること。