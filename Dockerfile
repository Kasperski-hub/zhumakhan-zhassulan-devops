# Base image: official slim Python image
FROM python:3.12-slim

LABEL maintainer="Zhumakhan Zhassulan" \
      group="IT2-2308" \
      student_id="37359"

# Default values; they can be overridden with `docker run -e ...`
ENV PYTHONUNBUFFERED=1 \
    STUDENT_NAME=Zhassulan \
    STUDENT_SURNAME=Zhumakhan \
    STUDENT_GROUP=IT2-2308 \
    STUDENT_ID=37359 \
    APP_PORT=8000 \
    SERVE=false

# All following commands run inside /app
WORKDIR /app

# Copy the application code and its configuration into the image
COPY app/ ./app/
COPY config/ ./config/

# Create a non-root user and a logs directory
RUN useradd --create-home appuser \
    && mkdir -p /app/logs \
    && chown -R appuser:appuser /app

USER appuser

# Port used when SERVE=true
EXPOSE 8000

CMD ["python", "app/app.py"]
