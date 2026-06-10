# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/threads', type: :request do
  path '/api/v1/games/{id}/threads' do
    parameter name: :id, in: :path, schema: { type: :string }, required: true, description: 'GamedbGame game_id.'

    get "List the Discord threads linked to a game" do
      tags 'Threads'
      description 'The Discord threads mapped to the game through `thread_game_links` ' \
                  '(a thread can link to several games), newest thread first. Each row ' \
                  'carries the thread metadata (`thread_name`, `forum_channel_id`, ' \
                  '`is_archived`, `last_seen_at`) plus a computed `jump_url` deep link. ' \
                  'Read-only — the bot owns every thread/link write.'
      produces 'application/json'
      parameter name: :page, in: :query, schema: { type: :integer, default: 1, minimum: 1 }, required: false
      parameter name: :per, in: :query, schema: { type: :integer, default: 50, maximum: 500 }, required: false
      parameter name: :limit, in: :query, schema: { type: :integer, maximum: 500 }, required: false,
        description: 'Deprecated alias for `per` (transitional, for the unaudited Discord bot).'
      parameter name: :offset, in: :query, schema: { type: :integer, minimum: 0 }, required: false,
        description: 'Deprecated; converted to a page number (transitional, for the unaudited Discord bot).'

      response '200', 'threads list' do
        schema type: :object, properties: {
          data: { type: :array, items: { type: :object, additionalProperties: true } },
          meta: { '$ref' => '#/components/schemas/PaginationMeta' }
        }
      end

      response '401', 'unauthenticated' do
        schema '$ref' => '#/components/schemas/Error'
      end
    end
  end
end
