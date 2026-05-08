# frozen_string_literal: true

module Gamedb
  class IgdbImageImportPopulator
    DEFAULT_LOGGER = lambda do |message, stream: $stdout|
      stream.puts(message)
    end

    def initialize(importer: IgdbImageImporter.new, logger: DEFAULT_LOGGER)
      @importer = importer
      @logger = logger
    end

    def call(game_id: nil, limit: nil, force: false, dry_run: false)
      processed = 0
      imported = 0
      failed = 0

      each_game(game_id: game_id, limit: limit, force: force) do |game|
        processed += 1
        log("#{dry_run ? '[dry-run] ' : ''}#{game.game_id} #{game.title} igdb=#{game.igdb_id}")

        next if dry_run

        result = @importer.import!(game)
        imported += result.images.size
        log("  imported #{result.images.size} image(s)")
      rescue IgdbImageImporter::MissingIgdbGameError,
             Gamedb::GameImageStorage::InvalidImageError,
             Backblaze::Client::RequestError,
             Igdb::Client::RequestError => e
        failed += 1
        log("  failed: #{e.message}", stream: $stderr)
      end

      { processed: processed, imported: imported, failed: failed }
    end

    private

    def each_game(game_id:, limit:, force:, &block)
      scope = GamedbGame.where.not(igdb_id: nil)
      scope = scope.where(game_id: game_id) if game_id.present?
      scope = scope.where.not(game_id: GamedbGameImage.select(:game_id)) unless force

      yielded = 0
      scope.find_each do |game|
        yield game
        yielded += 1
        break if limit.present? && yielded >= limit
      end
    end

    def log(message, stream: $stdout)
      @logger.call(message, stream: stream)
    end
  end
end
