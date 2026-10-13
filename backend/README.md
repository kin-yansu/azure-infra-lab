# FastAPIバックエンド

Python 3.10以上で実行する。以下はリポジトリのルートから実行する。

```bash
python3 -m venv backend/.venv
source backend/.venv/bin/activate
python -m pip install -r backend/requirements.txt
python -m uvicorn app.main:app --app-dir backend --reload
```

開発サーバーは`http://127.0.0.1:8000`で起動する。`--reload`は開発時のみ使用する。

```bash
curl http://127.0.0.1:8000/health
# {"status":"ok"}

curl http://127.0.0.1:8000/
# {"service":"azure-infra-lab","environment":"local"}
```

API仕様は`http://127.0.0.1:8000/docs`で確認できる。
環境名は起動時に`APP_ENV`で指定する。

```bash
APP_ENV=staging python -m uvicorn app.main:app --app-dir backend
```

採用方針は[ADR-001](../docs/adr/ADR-001-fastapi-backend.md)を参照。
