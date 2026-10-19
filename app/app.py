#!/usr/bin/env python3
"""DevOps student application.

Prints the student's information. The values are read from environment
variables (STUDENT_NAME, STUDENT_SURNAME, STUDENT_GROUP, STUDENT_ID), so they
can be changed with `docker run -e ...` without rebuilding the image.

If SERVE=true, the same text is also served over HTTP on APP_PORT (default 8000).
"""
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

CONFIG_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "config", "app.conf")


def load_config(path=CONFIG_FILE):
    """Read KEY=VALUE pairs from config/app.conf (comments and blank lines are skipped)."""
    config = {}
    if os.path.exists(path):
        with open(path, encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#") and "=" in line:
                    key, value = line.split("=", 1)
                    config[key.strip()] = value.strip()
    return config


def build_message(config):
    line = "=" * 32
    return "\n".join([
        line,
        "DevOps Student Application",
        line,
        "",
        f"Name: {os.getenv('STUDENT_NAME', 'Zhassulan')}",
        f"Surname: {os.getenv('STUDENT_SURNAME', 'Zhumakhan')}",
        f"Group: {os.getenv('STUDENT_GROUP', 'IT2-2308')}",
        f"Student ID: {os.getenv('STUDENT_ID', '37359')}",
        "",
        f"App version: {config.get('APP_VERSION', 'unknown')}",
        "",
        "Application is running successfully!",
    ])


def serve(message, port):
    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            body = (message + "\n").encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/plain; charset=utf-8")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)

    print(f"Serving on port {port} (open http://localhost:{port})", flush=True)
    HTTPServer(("0.0.0.0", port), Handler).serve_forever()


def main():
    config = load_config()
    message = build_message(config)
    print(message, flush=True)

    if os.getenv("SERVE", "false").lower() == "true":
        port = int(os.getenv("APP_PORT", config.get("APP_PORT", "8000")))
        serve(message, port)


if __name__ == "__main__":
    main()
