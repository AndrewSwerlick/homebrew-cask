cask 'eventstore' do
  version '3.9.3'
  sha256 'a4ceca878a833e4f30235b08ce1764d5072935484c126c93fb05ab2188a2a9ee'

  url "http://download.geteventstore.com/binaries/EventStore-OSS-MacOSX-v#{version}.tar.gz"
  name 'Greg Youngs Event Store'
  name 'Event Store'
  homepage 'https://geteventstore.com/'

  binary "#{staged_path}/eventstore", target: 'eventstore'
  binary "#{staged_path}/eventstore-testclient", target: 'eventstore-testclient'

  preflight do
    IO.write "#{staged_path}/eventstore", <<-EOS.undent
      #!/bin/sh
      cd "#{staged_path}/EventStore-OSS-MacOSX-v#{version}"
      exec "./run-node.sh" "$@"
    EOS
    FileUtils.chmod '+x', "#{staged_path}/eventstore"

    IO.write "#{staged_path}/eventstore-testclient", <<-EOS.undent
      #!/bin/sh
      cd "#{staged_path}/EventStore-OSS-MacOSX-v#{version}"
      exec "./testclient" "$@"
    EOS
    FileUtils.chmod '+x', "#{staged_path}/eventstore-testclient"
  end
end
