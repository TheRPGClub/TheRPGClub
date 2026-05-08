# frozen_string_literal: true

namespace :gamedb do
  desc "Import IGDB cover/artwork images into Backblaze. Usage: bin/rails gamedb:import_images GAME_ID=5884"
  task import_images: :environment do
    result = Gamedb::IgdbImageImportPopulator.new.call(
      game_id: ENV.fetch("GAME_ID", nil),
      limit: ENV.fetch("LIMIT", nil)&.to_i,
      force: ENV.fetch("FORCE", "false") == "true",
      dry_run: ENV.fetch("DRY_RUN", "false") == "true"
    )

    puts "Processed #{result[:processed]}, imported #{result[:imported]}, failed #{result[:failed]}"
  end
end
