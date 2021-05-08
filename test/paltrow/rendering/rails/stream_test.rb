require "timecop"

module Paltrow
  module Rendering
    module Rails
      class StreamTest < Minitest::Test
        def test__given_streaming__then_sets_headers_so_browser_correctly_handles_download
          Timecop.freeze(Time.local(2003, 2, 1, 10, 11, 12)) do
            headers = {}
            response = spy(:response, headers: headers, stream: spy(:stream))
            controller = spy(:controller, response: response)
            page = build(
              :page,
              locals: {
                filename: "download.pdf",
                content_stream: ContentStream.new(Dry::Monads::Success("chunk"))
              }
            )

            Stream.new.call(
              handler: controller,
              page: page
            )

            assert_equal headers, {
              "Content-Disposition" => "attachment; filename=\"download.pdf\"; filename*=UTF-8''download.pdf",
              "Cache-Control" => "no-cache",
              "Last-Modified" => "Sat, 01 Feb 2003 10:11:12 GMT",
              "X-Accel-Buffering" => "no"
            }
            expect(response).to have_received(:delete_header).with("Content-Length")
          end
        end

        def test__given_streaming__then_streams_successful_chunk
          stream = spy(:stream)
          controller = spy(:controller, response: spy(:response, headers: {}, stream: stream))
          page = build(
            :page,
            locals: {
              filename: "download.pdf",
              content_stream: ContentStream.new(Dry::Monads::Success("chunk"))
            }
          )

          Stream.new.call(
            handler: controller,
            page: page
          )

          expect(stream).to have_received(:write).with("chunk")
        end

        def test__given_stream_crashes__then_closes_stream_to_prevent_memory_leak
          headers = {}
          stream = spy(:stream)
          response = spy(:response, headers: headers, stream: stream)
          controller = spy(:controller, response: response)
          page = build(
            :page,
            locals: {
              filename: "download.pdf",
              content_stream: CrashingContentStream.new
            }
          )

          assert_raises ArgumentError do
            Stream.new.call(
              handler: controller,
              page: page
            )
          end

          expect(stream).to have_received(:close)
        end
      end

      class CrashingContentStream
        def each_chunk
          raise ArgumentError, "Something went wrong when streaming"
        end
      end

      class ContentStream
        def initialize fragment_result
          @fragment_result = fragment_result
        end

        def each_chunk &block
          block.call(@fragment_result)
        end
      end
    end
  end
end
