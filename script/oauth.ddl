--
--  Oauth sql  -- MYSQL
--

DROP TABLE IF EXISTS oauth_client_details;
CREATE TABLE oauth_client_details (
  client_id               VARCHAR(255) PRIMARY KEY,
  resource_ids            VARCHAR(255),
  client_secret           VARCHAR(255),
  scope                   VARCHAR(255),
  authorized_grant_types  VARCHAR(255),
  web_server_redirect_uri VARCHAR(255),
  authorities             VARCHAR(255),
  access_token_validity   INTEGER,
  refresh_token_validity  INTEGER,
  additional_information  TEXT,
  create_time             TIMESTAMP    DEFAULT now(),
  archived                TINYINT(1)   DEFAULT '0',
  trusted                 TINYINT(1)   DEFAULT '0',
  autoapprove             VARCHAR(255) DEFAULT 'false'
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS oauth_access_token;
CREATE TABLE oauth_access_token (
  create_time       TIMESTAMP DEFAULT now(),
  token_id          VARCHAR(255),
  token             BLOB,
  authentication_id VARCHAR(255),
  user_name         VARCHAR(255),
  client_id         VARCHAR(255),
  authentication    BLOB,
  refresh_token     VARCHAR(255)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS oauth_refresh_token;
CREATE TABLE oauth_refresh_token (
  create_time    TIMESTAMP DEFAULT now(),
  token_id       VARCHAR(255),
  token          BLOB,
  authentication BLOB
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS oauth_code;
CREATE TABLE oauth_code (
  create_time    TIMESTAMP DEFAULT now(),
  code           VARCHAR(255),
  authentication BLOB
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS oauth_approvals;
CREATE TABLE oauth_approvals (
  userId         VARCHAR(255),
  clientId       VARCHAR(255),
  status         VARCHAR(255),
  expiresAt      TIMESTAMP,
  lastModifiedAt TIMESTAMP DEFAULT now(),
  scope          VARCHAR(255)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- Add indexes
CREATE INDEX approvals_id_index ON oauth_approvals (clientId, userId);
CREATE INDEX token_id_index ON oauth_access_token (token_id);
CREATE INDEX authentication_id_index ON oauth_access_token (authentication_id);
CREATE INDEX user_name_index ON oauth_access_token (user_name);
CREATE INDEX client_id_index ON oauth_access_token (client_id);
CREATE INDEX refresh_token_index ON oauth_access_token (refresh_token);
CREATE INDEX token_id_index ON oauth_refresh_token (token_id);
CREATE INDEX code_index ON oauth_code (code);