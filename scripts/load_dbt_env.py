from __future__ import annotations

import os
from pathlib import Path


def load_env_file(env_path: Path | None = None) -> None:
    path = env_path or Path(__file__).resolve().parents[1] / ".env"
    if not path.exists():
        return

    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        if key and key not in os.environ:
            os.environ[key] = value


if __name__ == "__main__":
    load_env_file()
