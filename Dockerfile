FROM haskell:8

WORKDIR /opt/example

RUN cabal update

# Add just the .cabal file to capture dependencies
COPY ./todo-example.cabal /opt/example/example.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
# (unless the .cabal file changes!)
RUN cabal build  -j4

# Add and Install Application Code
COPY . /opt/example
RUN cabal install

CMD ["example"]