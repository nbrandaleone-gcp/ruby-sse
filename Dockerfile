# Use the official Ruby image.
# https://hub.docker.com/_/ruby
# We must use the full image [~ 300 MB] so that the web server [puma] can build local
# extensions which allow for superior performance. I will explore other web servers
# in the future which might allow for smaller images [i.e. falcon].
FROM ruby:3 

# Install production dependencies.
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
ENV BUNDLE_FROZEN=true
RUN gem install bundler && bundle config set --local without test && bundle install

# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
CMD ["bundle", "exec", "puma", "-p", "8080"]
