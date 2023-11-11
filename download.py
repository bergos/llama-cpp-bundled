import os
from huggingface_hub import snapshot_download

snapshot_download(
  repo_id = os.getenv("MODEL", "mistralai/Mistral-7B-Instruct-v0.1"),
  allow_patterns = ["*.bin", "*.json", "*.model"],
  local_dir = "/model"
)
