# ─── BASE IMAGE ─────────────────────────────────
FROM python:3.11-slim

# ─── METADATA ───────────────────────────────────
LABEL maintainer="swapnil@email.com"
LABEL version="1.0.0"

# ─── ENVIRONMENT VARIABLES ──────────────────────
ENV APP_ENV=production \
    PORT=5000 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# ─── WORKDIR ────────────────────────────────────
WORKDIR /app

# ─── DEPENDENCIES FIRST (cache optimization) ────
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ─── APP CODE ───────────────────────────────────
COPY . .

# ─── NON ROOT USER ──────────────────────────────
RUN groupadd -r appgroup && \
    useradd -r -g appgroup -d /app -s /sbin/nologin appuser && \
    chown -R appuser:appgroup /app

USER appuser

# ─── EXPOSE PORT ────────────────────────────────
EXPOSE 5000

# ─── START APP ──────────────────────────────────
CMD ["python", "app.py"]
