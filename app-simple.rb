class App
  def call(env)
    [200, { "content-type" => "text/plain" }, ["Hello World"]]
  end
end
