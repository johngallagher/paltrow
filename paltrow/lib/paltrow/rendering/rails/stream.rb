require "active_support/inflector/transliterate"

module Paltrow
  module Rendering
    module Rails
      class ContentDisposition # :nodoc:
        def self.format disposition:, filename:
          new(disposition: disposition, filename: filename).to_s
        end

        attr_reader :disposition, :filename

        def initialize disposition:, filename:
          @disposition = disposition
          @filename = filename
        end

        TRADITIONAL_ESCAPED_CHAR = /[^ A-Za-z0-9!\#$+.^_`|~-]/

        def ascii_filename
          'filename="' + percent_escape(I18n.transliterate(filename), TRADITIONAL_ESCAPED_CHAR) + '"'
        end

        RFC_5987_ESCAPED_CHAR = /[^A-Za-z0-9!\#$&+.^_`|~-]/

        def utf8_filename
          "filename*=UTF-8''" + percent_escape(filename, RFC_5987_ESCAPED_CHAR)
        end

        def to_s
          if filename
            "#{disposition}; #{ascii_filename}; #{utf8_filename}"
          else
            disposition.to_s
          end
        end

        private

        def percent_escape string, pattern
          string.gsub(pattern) do |char|
            char.bytes.map { |byte| "%%%02X" % byte }.join
          end
        end
      end

      class Stream
        def call handler:, view:
          handler.response.headers["Content-Disposition"] = ContentDisposition.format(
            disposition: "attachment",
            filename: view.locals.fetch(:filename)
          )
          handler.response.delete_header "Content-Length"
          handler.response.headers["Cache-Control"] = "no-cache"
          handler.response.headers["Last-Modified"] = Time.now.httpdate.to_s
          handler.response.headers["X-Accel-Buffering"] = "no"

          begin
            view
              .locals
              .fetch(:content_stream)
              .each_chunk { |chunk| handler.response.stream.write(chunk.value!) if chunk.success? }
          ensure
            handler.response.stream.close
          end
        end
      end
    end
  end
end
