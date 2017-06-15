defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

	match "/events/*path" do
		Proxy.forward conn, path, "http://resource/events/"
	end

	match "/locations/*path" do
		Proxy.forward conn, path, "http://resource/locations/"
	end

	match "/categories/*path" do
		Proxy.forward conn, path, "http://resource/categories/"
	end

	match "/contact-points/*path" do
		Proxy.forward conn, path, "http://resource/contact-points/"
	end

	match "/organizers/*path" do
		Proxy.forward conn, path, "http://resource/organizers/"
	end
	
  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
