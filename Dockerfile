FROM python:3.8 AS builder

WORKDIR /src
COPY . .

RUN python -m venv /opt/venv \
    && . /opt/venv/bin/activate \
    && pip install --no-cache-dir -U pip setuptools wheel \
    && pip install --no-cache-dir .

FROM python:3.8-slim
COPY --from=builder /opt/venv /opt/venv

ENV TZ="Asia/Shanghai"
ENV EK_IN_DOCKER="1"
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app
RUN touch config.toml