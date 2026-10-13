"""Infrastructure lab backend API."""

import os

from fastapi import FastAPI

app = FastAPI(title="Azure Infra Lab API")


@app.get("/")
def root() -> dict[str, str]:
    return {
        "service": "azure-infra-lab",
        "environment": os.getenv("APP_ENV", "local"),
    }


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.get("/environment")
def environment() -> dict[str, str]:
    return dict(os.environ)