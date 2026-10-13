# App Serviceのスロットスワップと環境変数の検証

## 目的
スワップによって、値が異なる環境変数と、
片方のスロットだけに存在する環境変数がどう変化するか確認する。

## 検証条件
- 実施日時：
- Gitコミット：
- リージョン：Japan East
- App Service Plan：Linux / S1 / 1インスタンス
- スロット：production、staging
- イメージ：両方とも kinfatman0001toyapp:v1
- スロット固定設定：なし

## スワップ前の結果

| 環境変数 | production | staging |
|---|---|---|
| APP_ENV |production |staging |
| APP_DEBUG |production |staging |
| PRODUCTION_SLOT_ONLY |production_slot_only |無し|
| STAGING_SLOT_ONLY |無し |staging_slot_only |

## 実施した操作
実行したコマンドと実行日時を記載する。

## スワップ後の結果

| 環境変数 | production | staging |
|---|---|---|
| APP_ENV |staging |production |
| APP_DEBUG |staging |production |
| PRODUCTION_SLOT_ONLY |無し |production_slot_only |
| STAGING_SLOT_ONLY |staging_slot_only |無し |

## デプロイスワップの設定にチェック

| 環境変数 | production | staging |
|---|---|---|
| APP_ENV |production |staging |
| APP_DEBUG |production |staging |
| PRODUCTION_SLOT_ONLY |production_slot_only |無し |
| STAGING_SLOT_ONLY |無し |staging_slot_only |
| DEPLOY_SLOT_COMMON_FIRST |production |staging |
| DEPLOY_SLOT_PRODUCTION |production |なし |
| DEPLOY_SLOT_STAGING |なし |staging |
| HOSTNAME |f670325beec8 |742578cf3499 |

## デプロイスワップの設定にチェックのスワップ後の結果

| 環境変数 | production | staging |
|---|---|---|
| APP_ENV |staging |production |
| APP_DEBUG |staging |production |
| PRODUCTION_SLOT_ONLY |無し |production_slot_only |
| STAGING_SLOT_ONLY |staging_slot_only |無し |
| DEPLOY_SLOT_COMMON_FIRST |staging |production |
| DEPLOY_SLOT_PRODUCTION |production |なし |
| DEPLOY_SLOT_STAGING |なし |staging |


## 結果

- スワップ前

```bash
Prodcution
Name                      Value                 SlotSetting
------------------------  --------------------  -------------
APP_DEBUG                 production            False
APP_ENV                   production            False
DEPLOY_SLOT_COMMON_FIRST  production            True
DEPLOY_SLOT_PRODUCTION    production            True
PRODUCTION_SLOT_ONLY      production_slot_only  False

Staging
Name                      Value    SlotSetting
------------------------  -------  -------------
APP_DEBUG                 staging  False
APP_ENV                   staging  False
DEPLOY_SLOT_COMMON_FIRST  staging  True
DEPLOY_SLOT_STAGING       staging  True
STAGING_SLOT_ONLY         staging  False

```
- スワップ後
```bash
Prodcution
Name                      Value       SlotSetting
------------------------  ----------  -------------
APP_DEBUG                 staging     False
APP_ENV                   staging     False
DEPLOY_SLOT_COMMON_FIRST  production  True
STAGING_SLOT_ONLY         staging     False
DEPLOY_SLOT_PRODUCTION    production  True

Staging
Name                      Value                 SlotSetting
------------------------  --------------------  -------------
APP_DEBUG                 production            False
APP_ENV                   production            False
DEPLOY_SLOT_COMMON_FIRST  staging               True
PRODUCTION_SLOT_ONLY      production_slot_only  False
DEPLOY_SLOT_STAGING       staging               True

```


## 考察

- スワップ前後で、値が異なる環境変数は入れ替わる。 production > staging、staging > production
- 片方のスロットだけに存在する環境変数は、スワップ後も元のスロットに残る。
- デプロイスワップの設定にチェックを入れると、スワップ後も元のスロットに残る。
- 片方のスロットだけに存在する環境変数かつデプロイスワップの設定にチェックを入れると、スワップ後も元のスロットに残る。

