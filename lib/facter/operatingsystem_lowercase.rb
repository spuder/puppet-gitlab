Facter.add("operatingsystem_lowercase") do
    setcode do
        Facter.value('operatingsystem').downcase
    end
end