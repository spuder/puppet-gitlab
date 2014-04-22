Facter.add("hostname_aliases") do
    setcode do
        Facter::Util::Resolution.exec('/bin/hostname --alias')
    end
end