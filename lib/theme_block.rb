# If only this was in core Ruby.
class Hash
  def except(*keys)
    dup.except!(*keys)
  end

  # Replaces the hash without the given keys.
  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end
end

module ThemeBlock
	def self.create(hsh)
		block = <<-EOT
		<dict>
			<key>name</key>
			<string>#{hsh['name']}</string>
			<key>scope</key>
			<string>#{hsh['scope']}</string>
			<key>settings</key>
			<dict>
		EOT

		# FIXME: Oh sod it can't be arsed, ugly way for now.
		hsh.delete('name')
		hsh.delete('scope')

		hsh.each do |k, v|
			block += <<-EOT
				<key>#{k}</key>
				<string>#{v}</string>
			EOT
		end
		block += "\t\t\t</dict>\n\t\t</dict>"

	block
	end
end