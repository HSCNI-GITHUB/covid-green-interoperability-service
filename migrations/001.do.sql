CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS nations (
  id UUID PRIMARY KEY NOT NULL DEFAULT GEN_RANDOM_UUID(),
  region TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS upload_batches (
  id SERIAL NOT NULL PRIMARY KEY,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NULL,
  nation_id UUID NOT NULL,
  tag TEXT NOT NULL CONSTRAINT upload_batches_tag_unique UNIQUE
);

CREATE TABLE IF NOT EXISTS download_batches (
  id SERIAL NOT NULL PRIMARY KEY,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  tag UUID NOT NULL DEFAULT GEN_RANDOM_UUID()
);

CREATE TABLE IF NOT EXISTS exposures (
  id SERIAL NOT NULL PRIMARY KEY,
  upload_batch_id INT NOT NULL,
  download_batch_id INT NULL,
  key_data TEXT NOT NULL CONSTRAINT exposures_key_data_unique UNIQUE,
  rolling_start_number INT NOT NULL,
  transmission_risk_level INT NOT NULL,
  rolling_period INT NOT NULL,
  regions TEXT[] NOT NULL
);

CREATE TABLE IF NOT EXISTS callbacks (
  id UUID PRIMARY KEY NOT NULL DEFAULT GEN_RANDOM_UUID(),
  nation_id UUID NOT NULL,
  url TEXT NOT NULL
);