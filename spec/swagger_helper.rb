# frozen_string_literal: true

require 'rails_helper'
require 'rswag/specs'
require_relative 'support/rswag_doc_only'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'The RPG Club API',
        version: 'v1',
        description: 'Backend API for The RPG Club. Authentication is performed with a bearer ' \
                     '`UserSessionToken` issued after Discord OAuth, or a service token for the bot.'
      },
      servers: [
        {
          url: '{host}',
          description: 'Development',
          variables: {
            host: {
              default: ENV.fetch('SWAGGER_API_HOST_DEV', 'http://localhost:3000')
            }
          }
        },
        {
          url: '{host}',
          description: 'Production',
          variables: {
            host: {
              default: ENV.fetch('SWAGGER_API_HOST_PROD', 'https://api.example.com')
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'UserSessionToken',
            description: 'Bearer token issued by `POST /auth/discord/callback` (user session) or ' \
                         'the service-account token used by the Discord bot.'
          }
        },
        schemas: {
          Error: {
            type: :object,
            properties: {
              error: { type: :string, example: 'not_found' },
              message: { type: :string, example: 'Couldn\'t find Record with id=42' }
            },
            required: %w[error]
          },
          PaginationMeta: {
            type: :object,
            description: 'Page-native pagination metadata (from pagy).',
            properties: {
              page: { type: :integer, example: 1 },
              pages: { type: :integer, example: 5 },
              count: { type: :integer, example: 123 },
              per: { type: :integer, example: 50 },
              prev: { type: :integer, example: nil, nullable: true },
              next: { type: :integer, example: 2, nullable: true }
            },
            required: %w[page pages count per]
          },
          DeletedResponse: {
            type: :object,
            properties: {
              deleted: { type: :boolean, example: true }
            },
            required: %w[deleted]
          }
        }
      },
      security: [ { bearerAuth: [] } ],
      paths: {}
    }
  }

  config.openapi_format = :yaml
end
