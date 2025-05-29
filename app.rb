# frozen_string_literal: true

class App
  def call(env)
    req = Rack::Request.new(env)
    path = req.path_info

    case path
    when "/"
      sse_js(env)
    when "/sse"
      sse(env)
    end
  end

  private

    def sse_js(env)
      body = <<~HTML
        <!DOCTYPE html>
        <html>
          <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>SSE - Demo</title>

            <script type="text/javascript">
              const eventSource = new EventSource("/sse")
              eventSource.addEventListener("message", event => {
                document.body.insertAdjacentHTML(
                  "beforeend",
                  `<p>${event.data}</p>`
                )
              })
            </script>
          </head>
          <body>
          </body>
        </html>
      HTML

      [200, { "content-type" => "text/html" }, [body]]
    end

    def sse(env)
      body = proc do |stream|
        Thread.new do
          5.times do
            stream.write "data: #{Time.now}!\n\n"
            sleep 1
          end
        ensure
          stream.close
        end
      end
 
      [200, { "content-type" => "text/event-stream" }, body]
    end
end

