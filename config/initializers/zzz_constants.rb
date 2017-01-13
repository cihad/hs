if User.table_exists?
	TEAM = Struct.new(:email, :username, :name).
	               new("destek@halkinsesi.com", "halkinsesi_ekip", "Halkın Sesi Takımı")

	ANONYMOUSUSER = AnonymousUser.new(role: "anonymous")
end