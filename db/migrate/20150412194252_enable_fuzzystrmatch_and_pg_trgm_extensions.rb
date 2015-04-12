class EnableFuzzystrmatchAndPgTrgmExtensions < ActiveRecord::Migration
  def up
    enable_extension "pg_trgm"
    enable_extension "fuzzystrmatch"
  end

  def down
    disable_extension "pg_trgm"
    disable_extension "fuzzystrmatch"
  end
end
